//
//  M_ExercisesForTimer.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 16.04.23.
//

import Foundation

struct ExercisesForTimer {
    
    var exerciseSet: ExerciseSet
    var currentExercise : Exercise
    var hasStartedExercise = false
    var remainingTime: Double
    var lastUsedExerciseSet = 0
    
    mutating func reduceRemainingTime(bySeconds sec: Double) {
        remainingTime -= sec
    }
    
}
