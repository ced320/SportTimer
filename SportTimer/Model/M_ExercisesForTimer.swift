//
//  M_ExercisesForTimer.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 16.04.23.
//

import Foundation


/// This struct is used to model the exercises that are used during the workout
struct M_ExercisesForTimer {
    
    private(set) var exerciseSet: M_ExerciseSet
    private(set) var currentExercise : M_Exercise
    private(set) var hasStartedExercise = false
    //private(set) var remainingTime: Double
    private(set) var currentExercisePositionInArray: Int
    
    
    /// reduce the internal remaining time
    /// - Parameter sec: in seconds
    /// - Returns: true if time has been reduced false else
//    mutating func reduceRemainingTime(bySeconds sec: Double) -> Bool {
//        remainingTime -= sec
//        if remainingTime <= 0 {
//            setToNextExercise()
//            return true
//        }
//        return false
//    }
    
    
    /// sets the internal parameter has started to the given bool parameter
    /// - Parameter newValueForHasStarted: newValueForHasStarted
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
        //remainingTime = currentExercise.durationInSeconds
    }
    
    
    /// resets the internal values to a state right before the workout starts
    mutating func resetToStartValues() {
        currentExercise = exerciseSet.exercises.first!
        //remainingTime = currentExercise.durationInSeconds
        hasStartedExercise = false
        currentExercisePositionInArray = 0
    }
    
    
    /// returns string that contains the next exercise name if there is no next exercise
    /// the string "There are no more exercises" will be returned
    /// - Returns: returns string that contains the next exercise name if there is no next exercise
    /// the string "There are no more exercises" will be returned
    func showNextExerciseName() -> String {
        if currentExercisePositionInArray+1 < exerciseSet.exercises.count {
            return exerciseSet.exercises[currentExercisePositionInArray+1].name
        }
        return "There are no more exercises"
    }
    
    
    /// returns string that displays the current exercise name
    /// - Returns: string that displays the current exercise name
    func showCurrentExerciseName() -> String {
        if currentExercisePositionInArray < exerciseSet.exercises.count {
            return exerciseSet.exercises[currentExercisePositionInArray].name
        }
        return "Error in showCurrentExerciseName: Index out of Bounds"
    }
    
    
    
    
}
