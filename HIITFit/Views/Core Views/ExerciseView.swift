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
    @State private var showSheet = false // controls whether to show or hide action sheet
    @EnvironmentObject var history: HistoryStore
    
    @State private var exerciseSheet: ExerciseSheet?
    private enum ExerciseSheet { // represents what kind of action sheet should be shown
        case history, timer, success
    }
    
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
                Spacer()
                ContainerView {
                    VStack {
                        video(size: geometry.size)
                        startExerciseButton
                            .padding(20)
                        RatingView(exerciseIndex: index)
                            .padding()
                        Spacer()
                        historyButton
                    }
                }
                .frame(height: geometry.size.height * 0.8)
                .sheet(isPresented: $showSheet) {
                    showSuccess = false
                    showHistory = false
                    if exerciseSheet == .timer {
                        if timerDone {
                            history.addDoneExercise(Exercise.exercises[index].exerciseName)
                            timerDone = false
                        }
                        showTimer = false
                        if lastExercise {
                            showSuccess = true
                            showSheet = true
                            exerciseSheet = .success
                        } else {
                            selectedTab += 1
                        }
                    } else {
                        exerciseSheet = nil
                    }
                    showTimer = false
                } content: {
                    if let exerciseSheet = exerciseSheet {
                        switch exerciseSheet {
                        case .history:
                            HistoryView(showHistory: $showHistory)
                                .environmentObject(history)
                        case .timer:
                            TimerView(
                                timerDone: $timerDone,
                                exerciseName: Exercise.exercises[index].exerciseName)
                        case .success:
                            SuccessView(selectedTab: $selectedTab)
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
            showSheet = true
            exerciseSheet = .timer // show the timer sheet as exercise is running.
        }
    }
    
    var historyButton: some View {
        Button {
            showHistory = true
            showSheet = true
            exerciseSheet = .history
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
