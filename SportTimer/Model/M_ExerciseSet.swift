//
//  ExerciseSet.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 10.04.23.
//

import Foundation

struct ExerciseSet : Codable, Identifiable, Equatable {
    static func == (lhs: ExerciseSet, rhs: ExerciseSet) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        return false
    }
    
    var id: Int
    var name: String
    var exercises: [Exercise]
}
