//
//  Exercise.swift
//  Timer
//
//  Created by Cedric Frimmel-Hoffmann on 11.08.22.
//

import Foundation

///This struct represents an Exercise
struct Exercise: Codable {
    let name: String
    let isPause: Bool
    private(set) var durationInSeconds: Double
    
    
}

