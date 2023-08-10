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
    //@State 
    @Environment(\.colorScheme) var colorScheme
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timerIsRunning = false
    @State var secondsToCompletion = 0
    let timeOfInterval: Int = 1
    @State var progress: Float = 0.0
    @State var animationToggle = false
    
    var body: some View {
        if(exerciseExecuter.timerManager == nil || !exerciseExecuter.timerManager!.hasStartedExercise) {
            beforeStartView
        } else {
            exerciseView
                .onDisappear{
                    //withAnimation {
                        exerciseExecuter.resetWorkoutToStart()
                    //}
                }
        }
    }
    
    ///View that is seen when the app is started or the workout has been finished
    var beforeStartView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(exerciseSetStorage.getThemeColors(type: .background, colorScheme: colorScheme))
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Exercise Timer")
                    .font(.title)
                    .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))
                Spacer()
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                    .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))
                    .onTapGesture {
                        //withAnimation {
                            //exerciseExecuter.resetWorkoutToStart()
                            exerciseExecuter.startWorkout(withThisExerciseSet: exerciseSetStorage.getSelectedExerciseSet())
                            secondsToCompletion = exerciseExecuter.timerManager!.currentExercise.durationInSeconds
                            //exerciseExecuter.updateAnimationParameters(passedTime: secondsToCompletion)
                            //exerciseExecuter.printRemainingTime()
                            timerIsRunning = true
                        //}
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
        //V_Experimental()
        ZStack {
            Rectangle()
                .foregroundColor(exerciseSetStorage.getThemeColors(type: .background, colorScheme: colorScheme))
                .ignoresSafeArea()
            VStack {
                if(exerciseExecuter.timerManager!.currentExercise.isPause) {
                    showPauseView
                } else {
                    showCurrentExerciseView
                }
                ZStack {
                    Text(exerciseExecuter.printRemainingTime(passedTimeInSeconds: secondsToCompletion))
                        .font(.system(size: 120))
                    if animationToggle {
                        CircularProgressView(progress: $progress)
                    } else {
                        CircularProgressView(progress: $progress)
                    }
                    
                }
                resetButtonView
            }
            .onReceive(timer) { time in
                if timerIsRunning {
                    secondsToCompletion -= 1
                        progress = Float(Float(exerciseExecuter.timerManager!.currentExercise.durationInSeconds)-Float(secondsToCompletion)) / Float(exerciseExecuter.timerManager!.currentExercise.durationInSeconds)

                    
                    if(secondsToCompletion < 0) {
                        exerciseExecuter.nextExercise()
                        secondsToCompletion = exerciseExecuter.timerManager!.currentExercise.durationInSeconds
                        progress = 0
                        animationToggle.toggle()
                    }
                }
            }
        }
    }
    ///View that is shown if the workout is in a pause
    var showCurrentExerciseView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(exerciseSetStorage.getThemeColors(type: .background, colorScheme: colorScheme))
                .ignoresSafeArea()
            VStack {
                Text("Current Exercise:")
                Text(exerciseExecuter.timerManager!.currentExercise.name)
                Image(systemName: "pause.circle")
                    .onTapGesture {
                        timerIsRunning.toggle()
                    }
            }
            .font(.largeTitle)
            .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))

            
        }
    }
    
    ///View that is shown while in an exercise
    var showPauseView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(exerciseSetStorage.getThemeColors(type: .background, colorScheme: colorScheme))
                .ignoresSafeArea()
            VStack {
                Text(exerciseExecuter.timerManager!.currentExercise.name)
                Text("Next Exercise:")
                Text(exerciseExecuter.showNextExerciseName())
                    .opacity(0.6)
                Image(systemName: "pause.circle")
                    .onTapGesture {
                        timerIsRunning.toggle()
                    }
            }
            .font(.largeTitle)
            .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))
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
                secondsToCompletion = 0
                progress = 0
            }.foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))
    }
}

struct V_ExerciseProgressView_Previews: PreviewProvider {
    static var previews: some View {
        V_WorkoutView()
            .environmentObject(MVC_ExerciseStorage())
    }
}
