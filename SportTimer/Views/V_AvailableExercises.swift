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
        List {
            Text("Currently selected: \(exerciseChooser.getSelectedExerciseSet().name)")
            ForEach(exerciseChooser.exerciseSets) { exerciseSet in
                Button(exerciseSet.name) {
                    if !deleteMode {
                        withAnimation {
                            exerciseChooser.chooseExerciseSet(exerciseSet: exerciseSet)
                        }
                    } else {
                        withAnimation {
                            exerciseChooser.deleteExerciseSet(uniqueIdOfExerciseSet: exerciseSet.id)
                        }
                    }
                }.foregroundColor(deleteMode ? .red : .blue)
            }
        }.toolbar {
            deleteOption
        }
        if !deleteMode {
            Text("Select an exercise-set")
                .padding()
        }
    }
    
    @ViewBuilder
    var deleteOption: some View {
        if deleteMode {
            HStack {
                Text("Tap to delete!")
                Image(systemName: "trash")
                    .onTapGesture {
                        withAnimation {
                            deleteMode.toggle()
                        }
                    }
            }.foregroundColor(.red)

        } else {
            HStack {
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
            .environmentObject(ExerciseChooser(named: "exerciseChooser"))
    }
}
