//
//  V_HomeView.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 16.04.23.
//

import SwiftUI

struct V_HomeView: View {
    
    @EnvironmentObject var exerciseSetStorage: MVC_ExerciseStorage
    @EnvironmentObject var exerciseExecuter: MVC_ExerciseExecuter
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    NavigationLink("Start Exercise") {
                        V_WorkoutView()
                            .environmentObject(exerciseSetStorage)
                    }
                    NavigationLink("Select Exercise") {
                            V_AvailableExercises()
                                .environmentObject(exerciseSetStorage)
                    }
                    NavigationLink("Create Exercise") {
                        V_CreateExerciseSetView()
                            .environmentObject(exerciseSetStorage)
                    }
                }
                .navigationTitle("Sportstimer")
            }
        }
   }
    
    
    
    
    struct constants {
        static let themeColor = Color.blue
        static let secondThemeColor = Color.red
    }
}

struct V_HomeView_Previews: PreviewProvider {
    static var previews: some View {
        V_HomeView()
            .environmentObject(MVC_ExerciseStorage(named: "exerciseChooser"))
    }
}
