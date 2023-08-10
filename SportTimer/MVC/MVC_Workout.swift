//
//  MVC_ExerciseExecuter.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 25.07.23.
//


 

import SwiftUI
import AVFAudio

/// used to model workout process 
class MVC_Workout: ObservableObject {
    
    @Published private(set) var currentExerciseSetForWorkout: M_ExerciseSet?
    @Published private(set) var timerManager : M_ExercisesForTimer?
    private var player: AVAudioPlayer!
    //for animation
    @Published var currentEndPoint: CGFloat = 0
    //@Published var timeOfInterval: Double = 1
    
    /// Used to model the workout process
    init() {
        self.currentExerciseSetForWorkout = nil
    }
    
    func updateAnimationParameters(passedTime: Int) {
        print("################")
        print("OldCurrentEnd \(currentEndPoint)")
        currentEndPoint = ((Double(passedTime)+1) / Double(getTotalTimeOfCurrentExercise()!))
        print("NewCurrentEnd \(currentEndPoint)")
        //print("RemaingTime \(timerManager!.remainingTime)")
        print("Total Time \(timerManager!.currentExercise.durationInSeconds)")
        
        print("################")
    }
    

    /// sets workout to has started
    /// - Parameter withThisExerciseSet: the exerciseSet that is used for the current workout
    /// - Returns: Void
    func startWorkout(withThisExerciseSet: M_ExerciseSet) -> Void {
        if setupWorkoutWithGivenSet(setForWorkout: withThisExerciseSet) {
            timerManager!.setHasStartedExercise(to: true)
        }
    }
    
    /// updated the time in the workout. So that internal parameters are updated
    /// - Parameter timeSinceLastUpdate: in seconds
    func nextExercise() {
        if timerManager != nil && timerManager!.hasStartedExercise {
            playSound(nextIsPause: timerManager!.currentExercise.isPause)
            timerManager!.setToNextExercise()
        }
    }
    
    
    /// Resets workout to start
    func resetWorkoutToStart() {
        if timerManager != nil {
            timerManager!.resetToStartValues()
            //currentEndPoint = 0
        }
    }
    
    /// as function names implies/Users/cedricfrimmel-hoffmann/Developer/SportTimer/SportTimer/MVC/MVC_CreateExerciseSet.swift
    /// - Returns: the current exercise name
    func showCurrentExerciseName() -> String {
        if timerManager != nil {
            return timerManager!.showCurrentExerciseName()
        }
        return "Error in showCurrentExerciseName() timerManager was nil"
    }
    
    /// as function name implies
    /// - Returns: name of next exercise
    func showNextExerciseName() -> String {
        if timerManager != nil {
            return timerManager!.showNextExerciseName()
        }
        return "Error in showNextExerciseName() timerManager was nil"
    }
    
    
    /// prints remaining seconds
    /// - Returns: remaining seconds as string
    func printRemainingTime(passedTimeInSeconds remainingTime: Int, timeMultiplicationFactor: Int) -> String {
        if timerManager != nil {
            //print(remainingTime)
            print("total time \(timerManager!.currentExercise.durationInSeconds)")
            return String(format: "%d", remainingTime/timeMultiplicationFactor)
        }
        return "Error in printRemainingTime() timerManager was nil"
    }
    
    
    private func getTotalTimeOfCurrentExercise() -> Int? {
        return timerManager?.currentExercise.durationInSeconds
    }
    
    struct parametersAnimation {
        let currentEndpoint: CGFloat
        let newEndPoint: CGFloat
    }
    
    /// Setups the workout for the next workout
    /// - Parameter setForWorkout: set for next workout
    /// - Returns: true if it could be set false else
    private func setupWorkoutWithGivenSet(setForWorkout: M_ExerciseSet) -> Bool{
        if setForWorkout.correctlyBuild() {
            currentExerciseSetForWorkout = setForWorkout
            let currentExercise = setForWorkout.exercises.first!
            timerManager = M_ExercisesForTimer(exerciseSet: setForWorkout, currentExercise: currentExercise, currentExercisePositionInArray: 0)
            return true
        }
        timerManager = nil
        return false
    }
    
    ///This function plays a sound depending on the type of exercises that has ended
    private func playSound(nextIsPause: Bool) {
        var pathToSound = "singleBeep"
        if(nextIsPause) {
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


