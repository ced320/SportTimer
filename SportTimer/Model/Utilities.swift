//
//  Utilities.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 15.04.23.
//

import Foundation

func generateUniqueIDForExercise(exerciseSets: [ExerciseSet]) -> Int {
    //1.) Get all existing IDs
    let existingIDs = getExistingIDsOfExercise(exerciseSets: exerciseSets)
    //2.) Find an ID that does not exist yet
    var candidate = 0
    var candidateExists = true
    while(candidateExists && candidate < 2_147_483_600) {
        candidateExists = false
        if(existingIDs.contains(candidate)) {
            candidate += 1
            candidateExists = true
        }
    }
    //3.) If there are no IDs left crash program
    if(candidateExists) {
        fatalError("There are no IDs left")
    }
    //4.) Give back that unique ID
    return candidate

}

func getExistingIDsOfExercise(exerciseSets: [ExerciseSet]) -> Set<Int> {
    var result: Set<Int> = Set()
    for exerciseSet in exerciseSets {
        let exercises = exerciseSet.exercises
        for exercise in exercises {
            result.insert(exercise.id)
        }
    }
    return result
}
