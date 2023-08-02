//
//  V_AvaibleExercises.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 13.04.23.
//

import SwiftUI

struct V_AvailableExercises: View {
    
    @EnvironmentObject var exerciseChooser: MVC_ExerciseStorage
    @State var deleteMode = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(exerciseChooser.getThemeColors(type: .background, colorScheme: colorScheme))
                .ignoresSafeArea()
            VStack {
            Text("Currently selected: \(exerciseChooser.getSelectedExerciseSet().name)")
            List (exerciseChooser.choosableWorkouts.exerciseSets){ exerciseSet in
                    Text(exerciseSet.name)
                    .foregroundColor(exerciseChooser.getThemeColors(type: .secondary, colorScheme: colorScheme))
                    .listRowBackground(exerciseChooser.getThemeColors(type: .primary, colorScheme: colorScheme))
                        .swipeActions {
                            Button {
                                exerciseChooser.deleteExerciseSet(uniqueIdOfExerciseSet: exerciseSet.name)
                            } label: {
                                Text("Delete")
                            }.tint(.red)
                        }
                        .onTapGesture {
                            exerciseChooser.chooseExerciseSet(exerciseSet: exerciseSet)
                        }
                        
                }
            .background(exerciseChooser.getThemeColors(type: .background, colorScheme: colorScheme))
            .scrollContentBackground(.hidden)
            }
        }

    }
}

struct V_AvaibleExercises_Previews: PreviewProvider {
    static var previews: some View {
        V_AvailableExercises()
            .environmentObject(MVC_ExerciseStorage())
    }
}
