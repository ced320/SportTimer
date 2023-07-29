//
//  V_HomeView.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 16.04.23.
//

import SwiftUI

struct V_HomeView: View {
    
    @EnvironmentObject var exerciseSetStorage: MVC_ExerciseStorage
    @EnvironmentObject var createExercise: MVC_CreateExerciseSet
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    NavigationLink("Start Exercise") {
                        V_WorkoutView()
                    }
                    NavigationLink("Select Exercise") {
                        V_AvailableExercises()
                    }
                    NavigationLink("Create Exercise") {
                        V_CreateExerciseSetView()
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
            .environmentObject(MVC_ExerciseStorage())
    }
}
