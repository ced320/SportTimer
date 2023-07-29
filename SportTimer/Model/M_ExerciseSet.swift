//
//  ExerciseSet.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 10.04.23.
//

import Foundation

struct M_ExerciseSet : Codable, Identifiable, Equatable {
    
    
    static func == (lhs: M_ExerciseSet, rhs: M_ExerciseSet) -> Bool {
        if lhs.name == rhs.name {
            return true
        }
        return false
    }
    
    private(set)var name: String
    private(set)var exercises: [M_Exercise]
    private(set)var id: String
    
    init(name: String, exercises: [M_Exercise]) {
        
        self.name = name
        self.exercises = exercises
        self.id = name
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
