//
//  ExerciseSet.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 10.04.23.
//

import Foundation

struct M_ExerciseSet : Codable, Identifiable, Equatable {
    static func == (lhs: M_ExerciseSet, rhs: M_ExerciseSet) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        return false
    }
    
    var id: Int
    var name: String
    var exercises: [M_Exercise]
    
    init(id: Int, name: String, exercises: [M_Exercise]) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
    
    init(exerciseSets: [M_ExerciseSet], name: String, exercises: [M_Exercise]) {
        
        self.name = name
        self.exercises = exercises
        
        self.id = {
            //1.) Get all existing IDs
            var result: Set<Int> = Set()
            for exerciseSet in exerciseSets {
                result.insert(exerciseSet.id)
            }
            let existingIDs = result
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
            return candidate}()
    }
}
