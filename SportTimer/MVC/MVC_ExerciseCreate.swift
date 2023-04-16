//
//  MVC_ExerciseCreater.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 15.04.23.
//

import SwiftUI

class MVC_ExerciseCreate: ObservableObject {

    @Published var temporaryCreatedExercises: [Exercise] = [Exercise]()
    @EnvironmentObject var exerciseChooser: ExerciseChooser
    
    
    func testPrint() {
        print("Hello from temporary")
    }
    
    func printAllAddedExercises() {
        for exercise in temporaryCreatedExercises {
            print(exercise.name)
            print(exercise.durationInSeconds)
            print("---------")
        }
    }
    
    private func createNewExercise() {}
    
    private func stringExerciseToExerciseStruct(name: String, duration: Double) -> Exercise {
        if duration < 0.1 {
            return exerciseChooser.createNewExercise(name: name, isPause: false, durationInSeconds: 0.1)
        }
        return exerciseChooser.createNewExercise(name: name, isPause: false, durationInSeconds: duration)
    }
    
    private func stringPauseToExerciseStruct(duration: Double) -> Exercise {
        if duration < 0.1 {
            return exerciseChooser.createNewExercise(name: "Pause", isPause: true, durationInSeconds: 0.1)
        }
        return exerciseChooser.createNewExercise(name: "Pause", isPause: true, durationInSeconds: duration)
    }
    
    func addInputToExerciseSet(existingExerciseSets: [ExerciseSet], name: String, duration: Double, pauseDuration: Double) {
        let exercise = stringExerciseToExerciseStruct(name: name, duration: duration)
        let pause = stringPauseToExerciseStruct(duration: pauseDuration)
        
        temporaryCreatedExercises.append(exercise)
        temporaryCreatedExercises.append(pause)
    }
    
    func printAllExerciseSets(existingExerciseSets: [ExerciseSet]) {
        for existingExerciseSet in existingExerciseSets {
            let exercises = existingExerciseSet.exercises
            for exercise in exercises {
                print(exercise.name)
                print(exercise.id)
                print(exercise.durationInSeconds)
            }
        }
    }
}


