//
//  MVC_ExerciseSetCreater.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 27.07.23.
//


import SwiftUI

class MVC_CreateExerciseSet: ObservableObject {

    @Published private(set) var exerciseSetBuilder: M_ExerciseSetBuilder
    
    /// Inits exerciseSetBuilder that is used to build exerciseSets
    init() {
        self.exerciseSetBuilder = M_ExerciseSetBuilder()
    }
    
    /// this function is called when the data shall be given to the storage
    /// it returns the build exerciseSet
    /// after the function was invoked the exerciseSet is cleared
    /// so that the next exerciseSet can be build
    /// - Parameter name: name of exerciseSet
    /// - Returns: exerciseSet with given name
    func addExerciseSet(nameOfSet name: String) -> M_ExerciseSet? {
        return exerciseSetBuilder.giveBackExerciseSetAndEmptyIt(nameOfSet: name)
    }
    
    
    /// adds exercise to tempExercises
    /// - Parameters:
    ///   - name: name of exercise
    ///   - isPause: isPause
    ///   - duration: in seconds
    func addExerciseToExerciseSet(name: String, isPause: Bool, durationInSeconds duration: Double) {
        if(name != "" && duration > 0) {
            exerciseSetBuilder.addExerciseToTemporarySet(nameOfExercise: name, isPause: isPause, durationInSeconds: duration)
        }
    }
    
    
    /// clears already added exercises in exerciseSetBuilder
    func resetTemporaryAddedExercises() {
        exerciseSetBuilder = M_ExerciseSetBuilder()
    }
    
    
    /// Checks that the exercises in exerciseSet builder are well build
    /// and can be used as ExerciseSets for ExerciseStorage
    /// - Returns: true if so else false
    func wellBuild() -> Bool {
        return exerciseSetBuilder.wellBuildTemporarySet()
    }
    
    
    
}
