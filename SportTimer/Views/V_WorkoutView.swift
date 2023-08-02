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
    
    //@State var animationCurrentEnd:CGFloat = 0.25
    //@State var animationNextEnd:CGFloat = 0.75
    
    //@State var currentEndPoint1: CGFloat = 0
    //@State var currentEndPoint2: CGFloat = 0
    //@State var finalEndPoint: CGFloat = 0//The percent of the circle that will be filled in the next interval
    let timeOfInterval: Double = 1
    //@State var animationPoints: MVC_Workout.parametersAnimation?
    
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
                        withAnimation {
                            //exerciseExecuter.resetWorkoutToStart()
                            exerciseExecuter.startWorkout(withThisExerciseSet: exerciseSetStorage.getSelectedExerciseSet())
                            //exerciseExecuter.updateAnimationParameters(lengthOfNextIntervalInSeconds: timeOfInterval)
                            //exerciseExecuter.printRemainingTime()
                            timerIsRunning = true
                        }
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
                Text(exerciseExecuter.printRemainingTime())
                    .font(.system(size: 120))
                animatedTimer
                    .onAppear {
                        withAnimation(.linear(duration: self.timeOfInterval)) {
                            exerciseExecuter.updateAnimationParameters(lengthOfNextIntervalInSeconds: 1)
                        }
                    }
                Text("Time left:")
                    .font(.subheadline)
                resetButtonView
            }
            .onReceive(timer) { time in
                if timerIsRunning {
                    
                    
                        
                    
                    exerciseExecuter.updateWorkoutTimer(timeSinceLastUpdate: 1)
                    if exerciseExecuter.currentEndPoint < 0.99 {
                        withAnimation(.linear(duration: self.timeOfInterval)) {
                            exerciseExecuter.updateAnimationParameters(lengthOfNextIntervalInSeconds: timeOfInterval)

                            //currentEndPoint2 = exerciseExecuter.calcParametersForAnimation(lengthOfNextTimeIntervalInSeconds: 1)!.newEndPoint
                        }
                    } else {
                        exerciseExecuter.updateAnimationParameters(lengthOfNextIntervalInSeconds: timeOfInterval)
                        exerciseExecuter.currentEndPoint = 0
                    }
                    


                    
                    
                }
            }
        }
    }
    
    var animatedTimer: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0, to: exerciseExecuter.currentEndPoint)
                    .stroke(LinearGradient(gradient: Gradient(colors: [.red]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing),
                            style: .init(lineWidth: 10, lineCap: .round))
                    .frame(width: 320, height: 320)
                    .opacity(1)
//                Circle()
//                    .trim(from: exerciseExecuter.currentEndPoint1, to: exerciseExecuter.finalEndPoint)
//                    .stroke(LinearGradient(gradient: Gradient(colors: [.blue]),
//                                           startPoint: .topLeading,
//                                           endPoint: .bottomTrailing),
//                            style: .init(lineWidth: 10, lineCap: .round))
//                    .frame(width: 320, height: 320)
//                    .opacity(0.5)
//                    .onReceive(timer) { time in
//                        if timerIsRunning {
//                            exerciseExecuter.updateWorkoutTimer(timeSinceLastUpdate: 1)
//                                withAnimation(.linear(duration: self.timeOfInterval)) {
//                                    exerciseExecuter.updateAnimationParameters(lengthOfNextIntervalInSeconds: timeOfInterval)
//
//                                    //currentEndPoint2 = exerciseExecuter.calcParametersForAnimation(lengthOfNextTimeIntervalInSeconds: 1)!.newEndPoint
//                                }
//
//                        }
//                    }
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
            }.foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))
    }
}

struct V_ExerciseProgressView_Previews: PreviewProvider {
    static var previews: some View {
        V_WorkoutView()
            .environmentObject(MVC_ExerciseStorage())
    }
}
