//
//  ExerciseTimer.swift
//  ExerciseTimer
//
//  Created by Cedric Frimmel-Hoffmann on 11.08.22.
//

import SwiftUI
//import AVFoundation


struct AppView: View {
   
    @StateObject var exerciseStorage = MVC_ExerciseStorage(named: "exerciseChooser")
    @StateObject var exerciseExecuter = MVC_Workout()
    //@StateObject var exerciseSetCreater = MVC_ExerciseSetCreater()

    var body: some View {
        V_HomeView()
            .environmentObject(exerciseStorage)
            .environmentObject(exerciseExecuter)
    }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
       AppView()
   }
}
