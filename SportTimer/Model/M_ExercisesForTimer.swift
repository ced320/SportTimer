//
//  M_ExercisesForTimer.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 16.04.23.
//

import Foundation

struct M_ExercisesForTimer {
    
    private(set) var exerciseSet: M_ExerciseSet
    private(set) var currentExercise : M_Exercise
    private(set) var hasStartedExercise = false
    private(set) var remainingTime: Double
    private(set) var currentExercisePositionInArray: Int
    
    mutating func reduceRemainingTime(bySeconds sec: Double) -> Bool {
        remainingTime -= sec
        if remainingTime <= 0 {
            setToNextExercise()
            return true
        }
        return false
    }
    
    mutating func setHasStartedExercise(to newValueForHasStarted:Bool) {
        hasStartedExercise = newValueForHasStarted
    }
    
    ///This function is called by the View if the time of the last exercise ran out
    ///or if needs to start the execution of exercises
    ///The function sets the current exercise to the next exercise if there is one(end of array)
    ///If the end of the array is reached
    mutating func setToNextExercise() {
        currentExercisePositionInArray += 1
        if(currentExercisePositionInArray < exerciseSet.exercises.count) {
            currentExercise = exerciseSet.exercises[currentExercisePositionInArray]
        } else {
            //Set back to default value that are the same as in the init()
            resetToStartValues()
            return
        }
        remainingTime = currentExercise.durationInSeconds
    }
    
    mutating func resetToStartValues() {
        currentExercise = exerciseSet.exercises.first!
        remainingTime = currentExercise.durationInSeconds
        hasStartedExercise = false
        currentExercisePositionInArray = 0
    }
    
    func showNextExerciseName() -> String {
        if currentExercisePositionInArray+1 < exerciseSet.exercises.count {
            return exerciseSet.exercises[currentExercisePositionInArray+1].name
        }
        return "There are no more exercises"
    }
    
    func showCurrentExerciseName() -> String {
        if currentExercisePositionInArray < exerciseSet.exercises.count {
            return exerciseSet.exercises[currentExercisePositionInArray].name
        }
        return "Error in showCurrentExerciseName: Index out of Bounds"
    }
    
    
    
    
}
