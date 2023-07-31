//
//  V_tempHomeView.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 31.07.23.
//

import SwiftUI

struct V_tempHomeView: View {
    
    @EnvironmentObject var exerciseSetStorage: MVC_ExerciseStorage
    @EnvironmentObject var createExercise: MVC_CreateExerciseSet
    
    
    var body: some View {
        NavigationView {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(exerciseSetStorage.getThemeColors(type: .background))
                    .ignoresSafeArea()
                VStack {
                    Text("IntervallTimer")
                        .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary))
                        .font(.largeTitle)
                        .padding(.top, 30)
                    threeOptions
                    Text("HeySub")
                        .foregroundColor(exerciseSetStorage.getThemeColors(type: .secondary))
                }
            }
        }
    }
    
    var threeOptions: some View {
        VStack {
            NavigationLink(destination: V_WorkoutView()) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.green)
            }
            NavigationLink(destination: V_AvailableExercises()) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.red)
            }
            NavigationLink(destination: V_CreateExerciseSetView()) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.black)
            }
        }
    }
}

struct V_tempHomeView_Previews: PreviewProvider {
    static var previews: some View {
        V_tempHomeView()
            .environmentObject(MVC_ExerciseStorage())
            .environmentObject(MVC_CreateExerciseSet())
    }
}
