//
//  ExerciseSet.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 10.04.23.
//

import Foundation

struct M_ExerciseSet : Codable, Identifiable, Equatable {
    
    
    /// Function that makes M_ExerciseSet Equatable
    /// - Parameters:
    ///   - lhs: M_ExerciseSet to compare left hand side
    ///   - rhs: M_ExerciseSet to compare right hand side
    /// - Returns: true if names are equal false else
    static func == (lhs: M_ExerciseSet, rhs: M_ExerciseSet) -> Bool {
        if lhs.name == rhs.name {
            return true
        }
        return false
    }
    
    private(set)var name: String
    private(set)var exercises: [M_Exercise]
    private(set)var id: String
    
    
    /// standart init
    /// - Parameters:
    ///   - uniqueName: unique name because it is used as identifier
    ///   - exercises: exercise that shall be part of the exercise
    init(uniqueName: String, exercises: [M_Exercise]) {
        
        self.name = uniqueName
        self.exercises = exercises
        self.id = uniqueName
    }
    ///This function shows that the ExerciseSet is correctly build and can be used for the Timer in a MVC
    /// - Returns: true if correctly build else false
    func correctlyBuild() -> Bool {
        if exercises.count < 1 {
            return false
        }
        for exercise in exercises {
            if !exercise.correctlyBuild() {
                return false
            }
        }
        return true
    }
    
    
}
