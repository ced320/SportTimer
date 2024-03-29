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
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(exerciseSetStorage.getThemeColors(type: .background, colorScheme: colorScheme))
                    .ignoresSafeArea()
                VStack {
                    Text("IntervallTimer")
                        .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))
                        .font(.largeTitle)
                        .padding(.top, 30)
                    GeometryReader { geo in
                        ScrollView {
                            threeOptions
                                .frame(height: geo.size.height * 0.8)
                        }
                    }.padding(.all, 30)
                }
            }
        }
    }
    
    var threeOptions: some View {
        VStack {
            ZStack {
                NavigationLink(destination: V_WorkoutView()) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))
                }
                Text("Start Workout")
                    .foregroundColor(exerciseSetStorage.getThemeColors(type: .secondary, colorScheme: colorScheme))
            }.padding(.top, 15)
            ZStack {
                NavigationLink(destination: V_AvailableExercises()) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))
                }
                Text("Select Workout")
                    .foregroundColor(exerciseSetStorage.getThemeColors(type: .secondary, colorScheme: colorScheme))
            }.padding(.top, 15)
            ZStack {
                NavigationLink(destination: V_CreateExerciseSetView()) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))
                }
                Text("Create Workout")
                    .foregroundColor(exerciseSetStorage.getThemeColors(type: .secondary, colorScheme: colorScheme))
            }.padding(.top, 15)
            
        }
    }
}

struct V_HomeView_Previews: PreviewProvider {
    static var previews: some View {
        V_HomeView()
            .environmentObject(MVC_ExerciseStorage())
            .environmentObject(MVC_CreateExerciseSet())
    }
}
