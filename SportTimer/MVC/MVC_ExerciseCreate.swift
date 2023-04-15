//
//  MVC_ExerciseCreater.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 15.04.23.
//

import SwiftUI

class MVC_ExerciseCreate: ObservableObject {

    @Published var temporaryCreatedExercises: [Exercise] = [Exercise]()
    
    func testPrint() {
        print("Hello from temporary")
    }
}


