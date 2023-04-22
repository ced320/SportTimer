//
//  CreateExerciseView.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 15.04.23.
//

import SwiftUI

struct CreateExerciseSet: View {
    
    @EnvironmentObject var exerciseChooser: ExerciseChooser
    
    @State var testSaver1: String = ""
    
    var body: some View {

        NavigationStack {
            Form {
                Section("Name of ExerciseSet") {
                    nameSection
                }
                Section("Add Exercise") {
                    NavigationLink("Create single exercise") {
                        exerciseSection
                    }
                }
                Section("Create ExerciseSet") {
                    createExerciseSection
                }
                Section("Exercise added") {
                    V_addedExerciseView()
                        .environmentObject(exerciseChooser)
                }
            }
        }
    }
    
    var nameSection: some View {
        TextField("Type name of set here", text: $testSaver1)
            //TextField("---", text: $testSaver1)
    }
    
    var exerciseSection: some View {

        V_CreateExerciseView2()
            .environmentObject(exerciseChooser)
            
    }
    
    @ViewBuilder
    var createExerciseSection: some View {
        if testSaver1 != "" && exerciseChooser.exerciseSetBuilder.temporaryCreatedExercises.count != 0 {
            Button("Create exercise-set") {
                withAnimation {
                    exerciseChooser.createExerciseSet(nameOfExerciseSet: testSaver1)
                }
            }
        }
        else {
            Text("Add name for set and/or exercises!")
        }

    }
}

struct CreateExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExerciseSet()
    }
}
