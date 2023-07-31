//
//  V_ExerciseProgressView.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 27.07.23.
//

import SwiftUI

struct V_WorkoutView: View {
    
    @EnvironmentObject var exerciseSetStorage: MVC_ExerciseStorage
    @StateObject var exerciseExecuter = MVC_Workout()

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
        ZStack {
            Rectangle()
                .foregroundColor(exerciseSetStorage.getThemeColors(type: .background))
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Exercise Timer")
                    .font(.title)
                    .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary))
                Spacer()
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                    .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary))
                    .onTapGesture {
                            exerciseExecuter.startWorkout(withThisExerciseSet: exerciseSetStorage.getSelectedExerciseSet())
                    }
                Spacer()
                Text("Press button to start Training")
                    .font(.footnote)
                Spacer()
            }.padding()
        }
    }
    
    ///View that is seen when the workout is started
    var exerciseView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(exerciseSetStorage.getThemeColors(type: .background))
                .ignoresSafeArea()
            VStack {
                if(exerciseExecuter.timerManager!.currentExercise.isPause) {
                    showPauseView
                } else {
                    showCurrentExerciseView
                }
                Text(exerciseExecuter.printRemainingTime())
                    .font(.system(size: 120))
                Text("Time left:")
                    .font(.subheadline)
                resetButtonView
            }
            .onReceive(timer) { time in
                exerciseExecuter.updateWorkoutTimer(timeSinceLastUpdate: 1)
            }
        }
    }
    
    ///View that is shown if the workout is in a pause
    var showCurrentExerciseView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(exerciseSetStorage.getThemeColors(type: .background))
                .ignoresSafeArea()
            VStack {
                Text("Current Exercise:")
                Text(exerciseExecuter.timerManager!.currentExercise.name)
            }
            .font(.largeTitle)
            .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary))
        }
    }
    
    ///View that is shown while in an exercise
    var showPauseView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(exerciseSetStorage.getThemeColors(type: .background))
                .ignoresSafeArea()
            VStack {
                Text(exerciseExecuter.timerManager!.currentExercise.name)
                Text("Next Exercise:")
                Text(exerciseExecuter.showNextExerciseName())
                    .opacity(0.6)
            }
            .font(.largeTitle)
            .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary))
        }
    }
    
    var resetButtonView: some View {
        VStack {
            Image(systemName: "arrow.counterclockwise.circle.fill")
                .aspectRatio(contentMode: .fit)
            Text("Reset")
                .font(.subheadline)
            }.padding()
            .onTapGesture {
                exerciseExecuter.resetWorkoutToStart()
            }.foregroundColor(exerciseSetStorage.getThemeColors(type: .primary))
    }
}

struct V_ExerciseProgressView_Previews: PreviewProvider {
    static var previews: some View {
        V_WorkoutView()
            .environmentObject(MVC_ExerciseStorage())
    }
}
