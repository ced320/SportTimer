//
//  MVC_ExerciseChooser.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 10.04.23.
//

import SwiftUI

class ExerciseChooser: ObservableObject {
    
    @Published private(set) var exerciseSets = [ExerciseSet]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    let name: String
    
    private var userDefaultsKey: String {"ExerciseSetStore"}
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(exerciseSets), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedExercisesSets = try? JSONDecoder().decode(Array<ExerciseSet>.self, from: jsonData) {
            exerciseSets = decodedExercisesSets
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if exerciseSets.isEmpty {
            exerciseSets.append(createDefaultExerciseSet())
        }
    }
    
    func getExerciseSet() -> ExerciseSet {
        return exerciseSets[0];
    }
    
    private func createDefaultExerciseSet() -> ExerciseSet {
        
        let pause5Sec = Exercise(name: "NEW_Pause",isPause: true, durationInSeconds: 5)
        let pause10Sec = Exercise(name: "Pause",isPause: true, durationInSeconds: 10)
        let pause15Sec = Exercise(name: "Pause",isPause: true, durationInSeconds: 15)
        
        var exercises = [Exercise]()
        exercises.append(pause5Sec)
        exercises.append(Exercise(name: "3NEW_SQUAD",isPause: false, durationInSeconds: 30))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "HANDS TO GROUND",isPause: false, durationInSeconds: 30))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "SITTING",isPause: false, durationInSeconds: 35))
        exercises.append(pause15Sec)
        exercises.append(Exercise(name: "RIGHT KNEE TO WALL",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "LEFT KNEE TO WALL",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "HANDS TO TABLE",isPause: false, durationInSeconds: 30))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "TABLE",isPause: false, durationInSeconds: 45))
        exercises.append(pause10Sec)
        exercises.append(Exercise(name: "2SQUAD",isPause: false, durationInSeconds: 30))
        
        return ExerciseSet(name: "test1", exercises: exercises)
    }
    
    
    
    
    
}
