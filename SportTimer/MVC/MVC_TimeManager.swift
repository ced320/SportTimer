//
//  ExerciseTimer.swift
//  ExerciseTimer
//
//  Created by Cedric Frimmel-Hoffmann on 11.08.22.
//

import Foundation
import SwiftUI
import AVFoundation

///This class handles the process of working with the exercise data
class TimerManager: ObservableObject {
    
    @Published var exerciseSet: ExerciseSet
    @Published var currentExercise : Exercise
    @Published var hasStartedExercise = false
    @Published var remainingTime: Double
    
    
    private var player: AVAudioPlayer!
    var exerciseCount = 1
    
    //Give an ExerciseTimer which contains the ordered array(first exercise at array[0]) with the exercises
    init() {
        self.exerciseSet = ExerciseSet(name: "dummy", exercises: [Exercise(name: "Dummy",isPause: false, durationInSeconds: 1)])
        currentExercise = Exercise(name: "Dummy",isPause: false, durationInSeconds: 1)
        hasStartedExercise = false
        remainingTime = 0
    }
    
    func startExercise(set: ExerciseSet) {
        exerciseSet = set
        resetExerciseProgramToStart()
        hasStartedExercise = true
    }
    
    
    
    ///This function is called by the View if the time of the last exercise ran out
    ///or if needs to start the execution of exercises
    ///The function sets the current exercise to the next exercise if there is one(end of array)
    ///If the end of the array is reached
    func setToNextExercise() {
        playSound(wasPause: currentExercise.isPause)
        if(exerciseCount < exerciseSet.exercises.count) {
            currentExercise = exerciseSet.exercises[exerciseCount]
        } else {
            //Set back to default value that are the same as in the init()
            hasStartedExercise = false
            exerciseCount = 1
            if let firstExercise = exerciseSet.exercises.first {
                currentExercise = firstExercise
                remainingTime = firstExercise.durationInSeconds
            } else {
                currentExercise = Exercise(name: "Dummy",isPause: false, durationInSeconds: 0)
                remainingTime = 0
            }
            return 
        }
        remainingTime = currentExercise.durationInSeconds
        exerciseCount += 1
    }
    
    func printRemainingTime() -> String {
        String(format: "%.0f", remainingTime)
    }
    
    func showNextExerciseName() -> String {
        if exerciseCount < exerciseSet.exercises.count {
            return exerciseSet.exercises[exerciseCount].name
        }
        return "This is the last Exercise"
    }
    
    func resetExerciseProgramToStart() {
        hasStartedExercise = false
        exerciseCount = 1
        if let firstExercise = exerciseSet.exercises.first {
            currentExercise = firstExercise
            remainingTime = firstExercise.durationInSeconds
        } else {
            currentExercise = Exercise(name: "Dummy",isPause: false, durationInSeconds: 0)
            remainingTime = 0
        }
    }
    
    ///This function plays a sound depending on the type of exercises that has ended
    private func playSound(wasPause: Bool) {
        var pathToSound = "singleBeep"
        if(!wasPause) {
            pathToSound = "doubleBeep"
        }
        let urlPossibleEmpty = Bundle.main.url(forResource: pathToSound, withExtension: "mp3")
        //Check that url is not empty
        guard let url = urlPossibleEmpty else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error with playing sound")
        }
    }
    
    
}
