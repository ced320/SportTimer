//
//  V_CreateExerciseView2.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 15.04.23.
//

import SwiftUI

struct V_CreateExerciseView2: View {
    
    @EnvironmentObject var exerciseChooser: ExerciseChooser
    
    //@FocusState var showKeyboard: Bool
    
    @State var nameOfExercise: String = "Exercise1"
    @State var durationOfExercise: Double = 30
    @State var durationOfPause: Double = 10
    
    var body: some View {
        VStack {
            List {
                TextField("Name", text: $nameOfExercise)
                TextField("durationOfExercise", value: $durationOfExercise, format: .number)
                TextField("durationOfPause", value: $durationOfPause, format: .number)
            }
            Button("Add exercise to set") {
                exerciseChooser.addInputToExerciseSet(name: nameOfExercise, duration: durationOfExercise, pauseDuration: durationOfPause)
                exerciseChooser.printAllAddedExercises()
                print("+++++++")
                exerciseChooser.printAllExerciseSets(existingExerciseSets: exerciseChooser.exerciseSets)
                
            }
            addedExercise
        }
    }
    
    var addedExercise: some View {
        ScrollView {
            ForEach(exerciseChooser.temporaryCreatedExercises) { exercise in
                VStack {
                    Text(exercise.name)
                }
            }
        }
    }
}

struct V_CreateExerciseView2_Previews: PreviewProvider {
    static var previews: some View {
        V_CreateExerciseView2()
    }
}
