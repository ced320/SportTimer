//
//  ExerciseTimer.swift
//  ExerciseTimer
//
//  Created by Cedric Frimmel-Hoffmann on 11.08.22.
//

import SwiftUI


struct AppView: View {
   
    @StateObject var exerciseStorage = MVC_ExerciseStorage(named: "exerciseChooser")
    //@StateObject var exerciseExecuter = MVC_Workout()
    @StateObject var createExercise = MVC_CreateExerciseSet()

    var body: some View {
        V_HomeView()
            .environmentObject(exerciseStorage)
            .environmentObject(createExercise)
    }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
       AppView()
   }
}
