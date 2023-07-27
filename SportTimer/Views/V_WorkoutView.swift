//
//  V_ExerciseProgressView.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 27.07.23.
//

import SwiftUI

struct V_WorkoutView: View {
    
    @EnvironmentObject var exerciseSetStorage: MVC_ExerciseStorage
    @EnvironmentObject var exerciseExecuter: MVC_ExerciseExecuter

    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        if(exerciseExecuter.timerManager == nil || !exerciseExecuter.timerManager!.hasStartedExercise) {
            beforeStartView
        } else {
            exerciseView
                .onDisappear{
                    withAnimation {
                        exerciseExecuter.resetWorkoutToStart()
                    }
                }
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
                        exerciseExecuter.startWorkout(withThisExerciseSet: exerciseSetStorage.getSelectedExerciseSet())
                        //exerciseSetStorage.startExercise(withSetNumber: exerciseSetStorage.currentExerciseSetPosition)
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
                if(exerciseExecuter.timerManager!.currentExercise.isPause) {
                    showPauseView.padding()
                } else {
                    showCurrentExerciseView
                }
                Spacer()
                Text(exerciseExecuter.printRemainingTime())
                    .font(.system(size: 120))
                Text("Time left:")
                    .font(.subheadline)
                Spacer()
                resetButtonView
                Spacer()
            }
            .onReceive(timer) { time in
                exerciseExecuter.updateWorkoutTimer(timeSinceLastUpdate: 1)
        }
    }
    
    ///View that is shown if the workout is in a pause
    var showCurrentExerciseView: some View {
        VStack {
            Text("Current Exercise:")
            Text(exerciseExecuter.timerManager!.currentExercise.name)
        }
        .font(.largeTitle)
        .foregroundColor(constants.themeColor)
    }
    
    ///View that is shown while in an exercise
    var showPauseView: some View {
        VStack {
            VStack {
                Text(exerciseExecuter.timerManager!.currentExercise.name)
            }
            VStack {
                Text("Next Exercise:")
                Text(exerciseExecuter.showNextExerciseName())
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
                    exerciseExecuter.resetWorkoutToStart()
                }

            }.foregroundColor(constants.themeColor)
    }
    
    struct constants {
        static let themeColor = Color.blue
        static let secondThemeColor = Color.red
    }
}

struct V_ExerciseProgressView_Previews: PreviewProvider {
    static var previews: some View {
        V_WorkoutView()
    }
}
