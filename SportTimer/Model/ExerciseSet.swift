//
//  ExerciseSet.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 10.04.23.
//

import Foundation

struct ExerciseSet : Codable {
    var name: String
    var exercises: [Exercise]
}
