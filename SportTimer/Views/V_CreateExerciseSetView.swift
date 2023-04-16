//
//  CreateExerciseView.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 15.04.23.
//

import SwiftUI

struct CreateExerciseSet: View {
    
    @EnvironmentObject var exerciseChooser: ExerciseChooser
    
    @State var testSaver1: String = "empty1"
    @State var testSaver2: String = "empty2"
    @State var testSaver3: String = "empty3"
    @State var testSaver4: String = "empty4"
    
    
    
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
            }
        }
    }
    
    var nameSection: some View {
            TextField("---", text: $testSaver1)
    }
    
    var exerciseSection: some View {

        V_CreateExerciseView2()
            .environmentObject(exerciseChooser)
            
    }
}

struct CreateExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExerciseSet()
    }
}
