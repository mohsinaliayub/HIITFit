//
//  ExerciseView.swift
//  HIITFit
//
//  Created by Mohsin Ali Ayub on 09.03.23.
//

import SwiftUI
import AVKit

struct ExerciseView: View {
    @Binding var selectedTab: Int
    @State private var showHistory = false
    @State private var showSuccess = false
    @State private var timerDone = false
    @State private var showTimer = false
    @EnvironmentObject var history: HistoryStore
    
    let index: Int
    var lastExercise: Bool {
        index + 1 == Exercise.exercises.count
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(selectedTab: $selectedTab,
                           titleText: Exercise.exercises[index].exerciseName)
                    .padding(.bottom)
                
                ContainerView {
                    VStack {
                        video(size: geometry.size)
                        
                        HStack(spacing: 150) {
                            startExerciseButton
                            
                            Button("Done") {
                                // add the exercise to History
                                history.addDoneExercise(Exercise.exercises[index].exerciseName)
                                
                                // When this button is enabled, timer is done,
                                // So you reset it to false to disable the button.
                                timerDone = false
                                showTimer.toggle() // hide the timer
                                
                                if lastExercise { showSuccess.toggle() }
                                else { selectedTab += 1 }
                            }
                            .disabled(!timerDone) // if timer is done, enable the button
                            .sheet(isPresented: $showSuccess) {
                                SuccessView(selectedTab: $selectedTab)
                            }
                        }
                        .font(.title3)
                        .padding()
                        
                        if showTimer {
                            TimerView(timerDone: $timerDone)
                        }
                        
                        Spacer()
                        
                        RatingView(exerciseIndex: index)
                            .padding()
                        
                        historyButton
                            .sheet(isPresented: $showHistory) {
                                HistoryView(showHistory: $showHistory)
                            }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func video(size: CGSize) -> some View {
        if let url = Bundle.main.url(forResource: Exercise.exercises[index].videoName, withExtension: "mp4") {
            VideoPlayer(player: AVPlayer(url: url))
                .frame(height: size.height * 0.25)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(20)
        } else {
            Text("Couldn't find \(Exercise.exercises[index].videoName).mp4")
                .foregroundColor(.red)
        }
    }
    
    var startExerciseButton: some View {
        RaisedButton(buttonText: "Start Exercise") {
            showTimer.toggle()
        }
    }
    
    var historyButton: some View {
        Button {
            showHistory = true
        } label: {
            Text(NSLocalizedString("History", comment: "view user activity"))
                .fontWeight(.bold)
                .padding([.leading, .trailing], 10)
        }
        .padding(.bottom, 10)
        .buttonStyle(EmbossedButtonStyle())
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(selectedTab: .constant(0), index: 0)
            .environmentObject(HistoryStore())
    }
}
