//
//  MVC_ExerciseExecuter.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 25.07.23.
//


 

import SwiftUI
import AVFAudio

class MVC_ExerciseExecuter: ObservableObject {
    
    @Published private(set) var currentExerciseSetForWorkout: M_ExerciseSet?
    @Published private(set) var timerManager : M_ExercisesForTimer?
    private var player: AVAudioPlayer!
    //private var exerciseCount = 1
    //private var currentExercise: M_Exercise?
    //private var remainingTime: Double?
    
    
    init() {
        self.currentExerciseSetForWorkout = nil
    }
    
    func startWorkout(withThisExerciseSet: M_ExerciseSet) -> Void {
        if setupWorkoutWithGivenSet(setForWorkout: withThisExerciseSet) {
            timerManager!.setHasStartedExercise(to: true)
        }
    }
    
    func updateWorkoutTimer(timeSinceLastUpdate: Double) {
        if timerManager != nil && timerManager!.hasStartedExercise {
            if timerManager!.reduceRemainingTime(bySeconds: timeSinceLastUpdate) {
                playSound(wasPause: timerManager!.currentExercise.isPause)
            }
        }
    }
    
    func resetWorkoutToStart() {
        if timerManager != nil {
            timerManager!.resetToStartValues()
        }
    }
    
    func showCurrentExerciseName() -> String {
        if timerManager != nil {
            return timerManager!.showCurrentExerciseName()
        }
        return "Error in showCurrentExerciseName() timerManager was nil"
    }
    
    func showNextExerciseName() -> String {
        if timerManager != nil {
            return timerManager!.showNextExerciseName()
        }
        return "Error in showNextExerciseName() timerManager was nil"
    }
    
    
    func printRemainingTime() -> String {
        if timerManager != nil {
            return String(format: "%.0f", timerManager!.remainingTime)
        }
        return "Error in printRemainingTime() timerManager was nil"
    }
    
    
    ///This function
    private func setupWorkoutWithGivenSet(setForWorkout: M_ExerciseSet) -> Bool{
        if setForWorkout.correctlyBuild() {
            currentExerciseSetForWorkout = setForWorkout
            let currentExercise = setForWorkout.exercises.first!
            let remainingTime = currentExercise.durationInSeconds
            timerManager = M_ExercisesForTimer(exerciseSet: setForWorkout, currentExercise: currentExercise, remainingTime: remainingTime, currentExercisePositionInArray: 0)
            return true
        }
        timerManager = nil
        return false
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


