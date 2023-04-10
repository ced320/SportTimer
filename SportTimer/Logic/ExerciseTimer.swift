//
//  ExerciseTimer.swift
//  ExerciseTimer
//
//  Created by Cedric Frimmel-Hoffmann on 11.08.22.
//

import Foundation

///This struct inits a ExerciseTimer
///The responsible of an ExerciseTimer is to save the order of execution of the exercises
///Furthermore it saves what the content of the exercises
///Precondition: Given Argument shall not be empty
struct ExerciseTimer {
    
    let exercises: [Exercise]

    //Init a custom Exercise Array
    init(arrayOfExercises exercises: [Exercise]) {
        //Prevent an empty array of Exercises.
        if exercises.isEmpty {
            assert(!exercises.isEmpty, "exercise should never be empty. But was empty. Standard exercise list was chosen to prevent problems")
            let dummyExercise = Exercise(name: "Dummy", isPause: false, durationInSeconds: 5)
            self.exercises = [dummyExercise]
        //Init exercises correctly
        } else {
            self.exercises = exercises
        }
    }
    
    //Init a predefined exerciseArray
    init() {
        let pause5Sec = Exercise(name: "Pause",isPause: true, durationInSeconds: 5)
        let pause10Sec = Exercise(name: "Pause",isPause: true, durationInSeconds: 10)
        let pause15Sec = Exercise(name: "Pause",isPause: true, durationInSeconds: 15)
        
        let exercise1 = Exercise(name: "SQUAD",isPause: false, durationInSeconds: 30)
        let exercise2 = Exercise(name: "HANDS TO GROUND",isPause: false, durationInSeconds: 30)
        let exercise3 = Exercise(name: "SITTING",isPause: false, durationInSeconds: 35)
        let exercise4 = Exercise(name: "RIGHT KNEE TO WALL",isPause: false, durationInSeconds: 30)
        let exercise5 = Exercise(name: "LEFT KNEE TO WALL",isPause: false, durationInSeconds: 30)
        let exercise6 = Exercise(name: "HANDS TO TABLE",isPause: false, durationInSeconds: 30)
        let exercise7 = Exercise(name: "TABLE",isPause: false, durationInSeconds: 45)
        let exercise8 = Exercise(name: "SQUAD",isPause: false, durationInSeconds: 30)
        
        self.exercises = [pause5Sec, exercise1, pause15Sec, exercise2, pause15Sec, exercise3,
                          pause15Sec, exercise4, pause10Sec, exercise5, pause10Sec,
                          exercise6, pause10Sec, exercise7, pause10Sec, exercise8]
    }
}
