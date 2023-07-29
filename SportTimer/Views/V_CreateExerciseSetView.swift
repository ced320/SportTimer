//
//  CreateExerciseView.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 15.04.23.
//

import SwiftUI

struct V_CreateExerciseSetView: View {
    
    @EnvironmentObject var exerciseChooser: MVC_ExerciseStorage
    @EnvironmentObject var createExerciseSet: MVC_CreateExerciseSet
    
    @State var testSaver1: String = ""
    @State var showWarning = false
    
    var body: some View {

        NavigationStack {
            Form {
                resetExercisesCreated
                Section("Name of ExerciseSet") {
                    nameSection
                }
                Section("Add Exercise") {
                    NavigationLink("Add new Exercise") {
                        exerciseSection
                    }
                }
                createExerciseSection
                Section("Exercise added") {
                    V_addedExerciseView()
                }
            }
        }
    }
    
    var resetExercisesCreated: some View {
        Button("Reset created Exercises") {
            withAnimation {
                createExerciseSet.resetTemporaryAddedExercises()
            }
        }.foregroundColor(.red)
    }
    
    var nameSection: some View {
        TextField("Type name of set here", text: $testSaver1)
            //TextField("---", text: $testSaver1)
    }
    
    var exerciseSection: some View {

        V_CreateExerciseView()
            .environmentObject(exerciseChooser)
            
    }
    
    @ViewBuilder
    var createExerciseSection: some View {
        if testSaver1 != "" && createExerciseSet.wellBuild() {
            Button("Create exercise-set") {
                withAnimation {
                    let temporarySet = createExerciseSet.addExerciseSet(nameOfSet: testSaver1)!
                    exerciseChooser.createExerciseSet(nameOfExerciseSet: temporarySet.name, exercisesOfSet: temporarySet.exercises)
                }
            }
        }
        else {
            Button("Add exercise-set-name and/or exercises first!") {
                showWarning = true
            }
            .foregroundColor(.red)
            .opacity(0.7)
            .alert("Add exercise-set-name and/or exercises first!", isPresented: $showWarning) {
            }
        }

    }


}

struct CreateExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        V_CreateExerciseSetView()
            .environmentObject(MVC_ExerciseStorage(named: "exerciseChooser"))
    }
}
