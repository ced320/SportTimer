//
//  ExerciseTimer.swift
//  ExerciseTimer
//
//  Created by Cedric Frimmel-Hoffmann on 11.08.22.
//

import SwiftUI
import AVFoundation


struct AppView: View {
   
    @StateObject var timerManager = TimerManager()
    @StateObject var exerciseChooser = ExerciseChooser(named: "excerciseChooser")
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if(!timerManager.hasStartedExercise) {
            beforeStartView
        } else {
            exerciseView
        }
   }
    
    ///View that is seen when the app is started or the workout has been finished
    var beforeStartView: some View {
        VStack {
            Spacer()
            Text("Exercise Timer")
                .font(.title)
                .foregroundColor(constants.themeColor)
            Spacer()
            Image(systemName: "play.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
                .foregroundColor(constants.themeColor)
                .onTapGesture {
                    withAnimation {
                        timerManager.startExercise(set: exerciseChooser.getExerciseSet())
                    }
                }
            Spacer()
            Text("Press button to start Training")
                .font(.footnote)
            Spacer()
        }.padding()
    }
    
    ///View that is seen when the workout is started
    var exerciseView: some View {

            VStack {
                Spacer()
                Spacer()
                if(timerManager.currentExercise.isPause) {
                    showPauseView.padding()
                } else {
                    showCurrentExerciseView
                }
                Spacer()
                Text(timerManager.printRemainingTime())
                    .font(.system(size: 120))
                Text("Time left:")
                    .font(.subheadline)
                Spacer()
                resetButtonView
                Spacer()
            }
            .onReceive(timer) { time in
            if timerManager.remainingTime > 0 && timerManager.hasStartedExercise {
                timerManager.remainingTime -= 1
            }
            if(timerManager.remainingTime <= 0) {
                //self.playSound()
                timerManager.setToNextExercise()
            }
            }
    }
    
    ///View that is shown if the workout is in a pause
    var showCurrentExerciseView: some View {
        VStack {
            Text("Current Exercise:")
            Text(timerManager.currentExercise.name)
        }
        .font(.largeTitle)
        .foregroundColor(constants.themeColor)
    }
    
    ///View that is shown while in an exercise
    var showPauseView: some View {
        VStack {
            VStack {
                Text(timerManager.currentExercise.name)
            }
            VStack {
                Text("Next Exercise:")
                Text(timerManager.showNextExerciseName())
            }
            .opacity(0.6)
        }
        .font(.largeTitle)
        .foregroundColor(constants.themeColor)
    }
    
    var resetButtonView: some View {


                VStack {
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .aspectRatio(contentMode: .fit)
                    Text("Reset")
                        .font(.subheadline)
                }.padding()
            .onTapGesture {
                withAnimation {
                    timerManager.resetExerciseProgramToStart()
                }

            }.foregroundColor(constants.themeColor)
    }
    
    
    
    struct constants {
        static let themeColor = Color.blue
        static let secondThemeColor = Color.red
    }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
       AppView()
   }
}
