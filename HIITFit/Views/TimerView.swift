//
//  TimerView.swift
//  HIITFit
//
//  Created by Mohsin Ali Ayub on 16.03.23.
//

import SwiftUI

struct TimerView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var timerDone: Bool
    @State private var timeRemaining = 3 // 30
    let exerciseName: String
    let timer = Timer.publish(
        every: 1,
        on: .main,
        in: .common)
        .autoconnect()
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("background")
                    .edgesIgnoringSafeArea(.all)
                circle(size: geometry.size)
                    .overlay(
                        GradientBackground()
                            .mask(circle(size: geometry.size))
                    )
                VStack {
                    Text(exerciseName)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    Spacer()
                    IndentView {
                        timerText
                    }
                    Spacer()
                    RaisedButton(buttonText: "Done") {
                        dismiss()
                    }
                    .opacity(timerDone ? 1 : 0)
                    .padding([.leading, .trailing], 30)
                    .padding(.bottom, 60)
                    .disabled(!timerDone)
                }
                .onAppear {
                    timerDone = false
                }
            }
        }
    }
    
    var timerText: some View {
        Text("\(timeRemaining)")
            .font(.system(size: 90, design: .rounded))
            .fontWeight(.heavy)
            .frame(
                minWidth: 180,
                maxWidth: 200,
                minHeight: 180,
                maxHeight: 200)
            .padding()
            .onReceive(timer) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    timerDone = true
                }
            }
    }
    
    func circle(size: CGSize) -> some View {
        Circle()
            .frame(
                width: size.width,
                height: size.height)
            .position(
                x: size.width * 0.5,
                y: -size.width * 0.2)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(
            timerDone: .constant(false),
            exerciseName: "Step Up")
    }
}
