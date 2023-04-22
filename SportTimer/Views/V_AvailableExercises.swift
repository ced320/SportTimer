//
//  V_AvaibleExercises.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 13.04.23.
//

import SwiftUI

struct V_AvailableExercises: View {
    
    @EnvironmentObject var exerciseChooser: ExerciseChooser
    @State var deleteMode = false
    
    var body: some View {
        ScrollView {
            deleteOption
            Spacer()
            ForEach(exerciseChooser.exerciseSets) { exerciseSet in
                Button(exerciseSet.name) {
                    if !deleteMode {
                        exerciseChooser.chooseExerciseSet(exerciseSet: exerciseSet)
                    } else {
                        exerciseChooser.deleteExerciseSet(uniqueIdOfExerciseSet: exerciseSet.id)
                    }

                }
            }
        }
    }
    
    @ViewBuilder
    var deleteOption: some View {
        if deleteMode {
            HStack {
                Text("DeletionMode activated!")
                Image(systemName: "trash")
                    .onTapGesture {
                        withAnimation {
                            deleteMode.toggle()
                        }
                    }
            }.foregroundColor(.red)

        } else {
            HStack {
                Text("Select an exercise-set")
                Image(systemName: "trash")
                    .onTapGesture {
                        withAnimation {
                            deleteMode.toggle()
                        }
                    }
            }.foregroundColor(.black)
        }
    }
}

struct V_AvaibleExercises_Previews: PreviewProvider {
    static var previews: some View {
        V_AvailableExercises()
    }
}
