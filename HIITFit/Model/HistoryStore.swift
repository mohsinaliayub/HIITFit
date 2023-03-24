//
//  HistoryStore.swift
//  HIITFit
//
//  Created by Mohsin Ali Ayub on 15.03.23.
//

import Foundation

struct ExerciseDay: Identifiable {
    let id: UUID
    let date: Date
    var exercises: [String] = []
    
    init(id: String, date: Date, exercises: [String]) {
        self.id = UUID(uuidString: id) ?? UUID()
        self.date = date
        self.exercises = exercises
    }
    
    init(date: Date, exercises: [String]) {
        self.id = UUID()
        self.date = date
        self.exercises = exercises
    }
}

class HistoryStore: ObservableObject {
    @Published var exerciseDays: [ExerciseDay] = []
    
    init() { }
    
    init(withChecking: Bool) throws {
        try load()
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
        
        do {
            try save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func load() throws {
        guard let dataURL = getURL() else {
            throw FileError.urlFailure
        }
        
        guard let data = try? Data(contentsOf: dataURL) else { return }
        
        let plistData = try PropertyListSerialization.propertyList(from: data, format: nil)
        
        let convertedPlistData = plistData as? [[Any]] ?? []
        
        // mapping our data from property list file to an array of ExerciseDay objects.
        exerciseDays = convertedPlistData.map({
            ExerciseDay(id: $0[0] as? String ?? UUID().uuidString, date: $0[1] as? Date ?? Date(), exercises: $0[2] as? [String] ?? [])
        })
    }
    
    /// Get the URL for the history file.
    private func getURL() -> URL? {
        guard let documentsURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return documentsURL.appending(path: "history.plist")
    }
    
    /// Persists the current exercise history to history file.
    private func save() throws {
        guard let dataURL = getURL() else {
            throw FileError.urlFailure
        }
        
        // convert each ExerciseDay element into an array of Any,
        // and append this to the array. We'll save plistData to disk.
        let plistData: [[Any]] = exerciseDays.map { exerciseDay in
            [
                exerciseDay.id.uuidString,
                exerciseDay.date,
                exerciseDay.exercises
            ]
        }
        
        do {
            let data = try PropertyListSerialization.data(fromPropertyList: plistData,
                                                          format: .binary, options: .zero)
            try data.write(to: dataURL, options: .atomic)
        } catch {
            throw FileError.saveFailure
        }
    }
    
    enum FileError: Error {
        case loadFailure
        case saveFailure
        case urlFailure
    }
}
