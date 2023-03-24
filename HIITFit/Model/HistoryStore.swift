//
//  HistoryStore.swift
//  HIITFit
//
//  Created by Mohsin Ali Ayub on 15.03.23.
//

import Foundation

struct ExerciseDay: Identifiable {
    let id = UUID()
    let date: Date
    var exercises: [String] = []
}

class HistoryStore: ObservableObject {
    @Published var exerciseDays: [ExerciseDay] = []
    
    init() {
//        createDevData()
    }
    
    func addDoneExercise(_ exerciseName: String) {
        let today = Date()
        
        // The first element of `exerciseDays´ is the user's most recent exercise day.
        // If today is the same date as this date, you append current exerciseName to exercises
        // array of this exerciseDay.
        if let firstDate = exerciseDays.first?.date, today.isSameDay(as: firstDate) {
            exerciseDays[0].exercises.append(exerciseName)
        } else {
            // Today is a new day, so create a new ExerciseDay object and insert it at the
            // beginning of the exerciseDays array as the most recent exercise.
            let exercise = ExerciseDay(date: today, exercises: [exerciseName])
            exerciseDays.insert(exercise, at: 0)
        }
    }
}
