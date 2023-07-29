//
//  M_ExerciseSetBuilder.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 20.04.23.
//

import Foundation

struct M_ExerciseSetBuilder {

    private(set) var exerciseSetThatShallBeAdded = [M_Exercise]()
    var tempIDsExercises = Set<Int>()
    
    
    
    /// This function adds a exercise To the exerciseSets that shall be added
    /// if duration > 0
    /// - Parameters:
    ///   - name: name
    ///   - isPause: isPause
    ///   - duration: duration has to be > 0
    mutating func addExerciseToTemporarySet(nameOfExercise name: String, isPause: Bool, durationInSeconds duration:Double) {
        if duration > 0  {
            let exercise = M_Exercise(uniqueId: makeNewUniqueExerciseId(), name: name, isPause: isPause, durationInSeconds: duration)
            exerciseSetThatShallBeAdded.append(exercise)
        }
    }
    
    
    /// This function gives back the currently build ExerciseSet
    /// and empties it to be able to create a new exerciseSet to add
    /// - Returns: the M_ExerciseSet that shall be added or nil if the currently build set is bad structured
    mutating func giveBackExerciseSetAndEmptyIt(nameOfSet:String) -> M_ExerciseSet? {
        if wellBuildTemporarySet() {
            let result = M_ExerciseSet(uniqueName: nameOfSet, exercises: exerciseSetThatShallBeAdded)
            exerciseSetThatShallBeAdded = [M_Exercise]()
            tempIDsExercises = Set<Int>()
            return result
        }
        return nil
    }
    
    func wellBuildTemporarySet() -> Bool {
        return exerciseSetThatShallBeAdded.count > 0
    }

    
    /// Creates a new id that does not already exists in this instance of M_ChoosableExerciseSets
    /// and adds it to existingIds
    /// - Returns: unique id
    private mutating func makeNewUniqueExerciseId() -> Int {
        var i = 0
        while(tempIDsExercises.contains(i)) {
            i = i + 1
        }
        tempIDsExercises.insert(i)
        return i
    }
}
