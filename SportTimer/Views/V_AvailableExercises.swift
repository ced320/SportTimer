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
    
    var body: some View {
        VStack {
        Text("Currently selected: \(exerciseChooser.getSelectedExerciseSet().name)")
        List (exerciseChooser.choosableWorkouts.exerciseSets){ exerciseSet in
                Text(exerciseSet.name)
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
            }.listStyle(PlainListStyle())
        }
    }
}

struct V_AvaibleExercises_Previews: PreviewProvider {
    static var previews: some View {
        V_AvailableExercises()
            .environmentObject(MVC_ExerciseStorage())
    }
}
