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
                        .environmentObject(exerciseChooser)
                }
            }
        }
    }
    
    var resetExercisesCreated: some View {
        Button("Reset created Exercises") {
            withAnimation {
                exerciseChooser.resetTemporaryCreatedExercises()
            }
        }.foregroundColor(.red)
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
        CreateExerciseSet()
    }
}
