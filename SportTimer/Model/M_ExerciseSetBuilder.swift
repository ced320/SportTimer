//
//  M_ExerciseSetBuilder.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 20.04.23.
//

import Foundation

struct ExerciseSetBuilder {
    var temporaryCreatedExercises: [Exercise] = [Exercise]()
    var nameOfExerciseSetToBuild: String?
    
    mutating func createExerciseSetWithGivenInput(exerciseSets: [ExerciseSet]) -> ExerciseSet? {
        if temporaryCreatedExercises.count > 0 && nameOfExerciseSetToBuild != nil {
            let exerciseSet = ExerciseSet(exerciseSets: exerciseSets, name: nameOfExerciseSetToBuild!, exercises: temporaryCreatedExercises)
            resetExerciseBuilder()
            return exerciseSet
        }
        return nil
    }
    
    mutating func setNameOfExerciseSet(nameOfExerciseSetToBuild: String) {
        self.nameOfExerciseSetToBuild = nameOfExerciseSetToBuild
    }
    
    private mutating func resetExerciseBuilder() {
        nameOfExerciseSetToBuild = nil
        temporaryCreatedExercises = [Exercise]()
    }
}
