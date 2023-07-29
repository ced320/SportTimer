//
//  MVC_ExerciseSetCreater.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 27.07.23.
//


import SwiftUI

class MVC_CreateExerciseSet: ObservableObject {

    @Published private(set) var exerciseSetBuilder: M_ExerciseSetBuilder
    
    init() {
        
        self.exerciseSetBuilder = M_ExerciseSetBuilder()

    }
    
    func addExerciseSet(nameOfSet name: String) -> M_ExerciseSet? {
        return exerciseSetBuilder.giveBackExerciseSetAndEmptyIt(nameOfSet: name)
    }
    
    func addExerciseToExerciseSet(name: String, isPause: Bool, durationInSeconds duration: Double) {
        if(name != "" && duration > 0) {
            exerciseSetBuilder.addExerciseToTemporarySet(nameOfExercise: name, isPause: isPause, durationInSeconds: duration)
        }
    }
    
    func resetTemporaryAddedExercises() {
        exerciseSetBuilder = M_ExerciseSetBuilder()
    }
    
    func wellBuild() -> Bool {
        return exerciseSetBuilder.wellBuildTemporarySet()
    }
    
    
    
}
