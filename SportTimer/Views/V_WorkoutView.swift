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
    
    let timer = Timer.publish(every: TimeInterval(1.0/Double(animationConstants.multiplicationTimeFactor)), on: .main, in: .common).autoconnect()
    @State var timerIsRunning = false
    @State var secondsToCompletion = 0
    //let timeOfInterval: Int = 1
    @State var progress: Float = 0.0
    @State var progress2: Float = 0.0
    @State var animationToggle = false
    
    var body: some View {
        if(exerciseExecuter.timerManager == nil || !exerciseExecuter.timerManager!.hasStartedExercise) {
            beforeStartView
        } else {
            exerciseView
                .onDisappear{
                    exerciseExecuter.resetWorkoutToStart()
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
                        secondsToCompletion = exerciseExecuter.timerManager!.currentExercise.durationInSeconds * animationConstants.multiplicationTimeFactor
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
        GeometryReader { geo in
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
                        Text(exerciseExecuter.printRemainingTime(passedTimeInSeconds: secondsToCompletion, timeMultiplicationFactor: animationConstants.multiplicationTimeFactor))
                            .font(.system(size: geo.size.height/5))
                            .bold()
                        //If else prevents animation from going backwards
                        if animationToggle {
                            CircularProgressView(progress: $progress)
                        } else {
                            CircularProgressView(progress: $progress2)
                        }
                    }
                    Text("Tap to pause")
                        .font(.footnote).padding(.all)
                    //resetButtonView
                }.frame(width: geo.size.width,height: geo.size.height)
                    .padding(.all)
                .onReceive(timer) { time in
                    if timerIsRunning {
                        secondsToCompletion -= 1
                        if animationToggle {
                            progress = Float(exerciseExecuter.timerManager!.currentExercise.durationInSeconds*animationConstants.multiplicationTimeFactor-secondsToCompletion) / Float(exerciseExecuter.timerManager!.currentExercise.durationInSeconds*animationConstants.multiplicationTimeFactor)
                        } else {
                            progress2 = Float(exerciseExecuter.timerManager!.currentExercise.durationInSeconds*animationConstants.multiplicationTimeFactor-secondsToCompletion) / Float(exerciseExecuter.timerManager!.currentExercise.durationInSeconds*animationConstants.multiplicationTimeFactor)
                        }
                        if(secondsToCompletion < 0) {
                            exerciseExecuter.nextExercise()
                            secondsToCompletion = exerciseExecuter.timerManager!.currentExercise.durationInSeconds*animationConstants.multiplicationTimeFactor
                            if animationToggle {
                                progress = 0
                            } else {
                                progress2 = 0
                            }
                            animationToggle.toggle()
                        }
                    }
                }
            }.onTapGesture {
                timerIsRunning.toggle()
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
                progress2 = progress
            }.foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))
    }
}

struct V_ExerciseProgressView_Previews: PreviewProvider {
    static var previews: some View {
        V_WorkoutView()
            .environmentObject(MVC_ExerciseStorage())
    }
}

struct animationConstants {
    static let multiplicationTimeFactor = 10
    static let animationEpsilon:Double = 0.1
}
