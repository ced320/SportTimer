//
//  Exercise.swift
//  Timer
//
//  Created by Cedric Frimmel-Hoffmann on 11.08.22.
//

import Foundation


/// This structs models an exercise for an interval timer
struct M_Exercise: Codable, Identifiable {
    let id: Int
    let name: String
    let isPause: Bool
    private(set) var durationInSeconds: Int
    
    /// standart initiator
    /// - Parameters:
    ///   - uniqueId: give a Unique id in the context the exercise is saved
    ///   - name: name of the exercise
    ///   - isPause: true if break false if exercise
    ///   - durationInSeconds: how long does the exercise take
    init(uniqueId: Int, name: String, isPause: Bool, durationInSeconds: Int) {
        self.id = uniqueId
        self.name = name
        self.isPause = isPause
        self.durationInSeconds = durationInSeconds
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

