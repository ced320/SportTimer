//
//  Exercise.swift
//  Timer
//
//  Created by Cedric Frimmel-Hoffmann on 11.08.22.
//

import Foundation

///This struct represents an Exercise
struct M_Exercise: Codable, Identifiable {
    let id: Int
    let name: String
    let isPause: Bool
    private(set) var durationInSeconds: Double

    init(id: Int, name: String, isPause: Bool, durationInSeconds: Double) {
        self.id = id
        self.name = name
        self.isPause = isPause
        self.durationInSeconds = durationInSeconds
    }
    
    init(existingIDs: [Int], name: String, isPause: Bool, durationInSeconds: Double) {
        self.name = name
        self.isPause = isPause
        self.durationInSeconds = durationInSeconds
        self.id = {
            //1.) Get all existing IDs
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
    
    ///This function shows that the Exercise is correctly build and can be used for the Timer in a MVC
    /// - Returns: true if correctly build else false
    func correctlyBuild() -> Bool {
        if durationInSeconds <= 0 {
            return false
        }
        return true
    }
    
    


}

