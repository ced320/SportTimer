//
//  V_HomeView.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 16.04.23.
//

import SwiftUI

struct V_HomeView: View {
    
    @EnvironmentObject var exerciseChooser: ExerciseChooser
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    NavigationLink("Start Exercise") {
                        if(!exerciseChooser.timerManager!.hasStartedExercise) {
                            beforeStartView
                        } else {
                            exerciseView
                                .onDisappear{
                                    withAnimation {
                                        exerciseChooser.resetExerciseProgramToStart()
                                    }
                                }
                        }
                    }
                    NavigationLink("Select Exercise") {
                            V_AvailableExercises()
                                .environmentObject(exerciseChooser)
                    }
                    NavigationLink("Create Exercise") {
                        CreateExerciseSet()
                            .environmentObject(exerciseChooser)
                    }
                }
                .navigationTitle("Sportstimer")
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
                        exerciseChooser.startExercise(withSetNumber: exerciseChooser.currentExerciseSetPosition)
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
                if(exerciseChooser.timerManager!.currentExercise.isPause) {
                    showPauseView.padding()
                } else {
                    showCurrentExerciseView
                }
                Spacer()
                Text(exerciseChooser.printRemainingTime())
                    .font(.system(size: 120))
                Text("Time left:")
                    .font(.subheadline)
                Spacer()
                resetButtonView
                Spacer()
            }
            .onReceive(timer) { time in
                if exerciseChooser.timerManager!.remainingTime > 0 && exerciseChooser.timerManager!.hasStartedExercise {
                    exerciseChooser.timerManager!.reduceRemainingTime(bySeconds: 1)
            }
                if(exerciseChooser.timerManager!.remainingTime <= 0) {
                //self.playSound()
                    exerciseChooser.setToNextExercise()
            }
        }
    }
    
    ///View that is shown if the workout is in a pause
    var showCurrentExerciseView: some View {
        VStack {
            Text("Current Exercise:")
            Text(exerciseChooser.timerManager!.currentExercise.name)
        }
        .font(.largeTitle)
        .foregroundColor(constants.themeColor)
    }
    
    ///View that is shown while in an exercise
    var showPauseView: some View {
        VStack {
            VStack {
                Text(exerciseChooser.timerManager!.currentExercise.name)
            }
            VStack {
                Text("Next Exercise:")
                Text(exerciseChooser.showNextExerciseName())
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
                    exerciseChooser.resetExerciseProgramToStart()
                }

            }.foregroundColor(constants.themeColor)
    }
    
    
    
    struct constants {
        static let themeColor = Color.blue
        static let secondThemeColor = Color.red
    }
}

struct V_HomeView_Previews: PreviewProvider {
    static var previews: some View {
        V_HomeView()
            .environmentObject(ExerciseChooser(named: "exerciseChooser"))
    }
}
