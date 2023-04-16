//
//  ExerciseTimer.swift
//  ExerciseTimer
//
//  Created by Cedric Frimmel-Hoffmann on 11.08.22.
//

import SwiftUI
import AVFoundation


struct AppView: View {
   
    @StateObject var exerciseChooser = ExerciseChooser(named: "exerciseChooser")

    var body: some View {
        V_HomeView()
            .environmentObject(exerciseChooser)
    }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
       AppView()
   }
}
