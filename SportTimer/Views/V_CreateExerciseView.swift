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
    
    @State var nameOfExercise: String = ""
    @State var durationOfPause: String = ""
    @State var durationOfExercise: String = ""
    @State var warningForWrongInput = false
    
    var body: some View {
        VStack {
            List {
                TextField("Name", text: $nameOfExercise)
                TextField("durationOfExercise", text: $durationOfExercise)
                TextField("durationOfPause", text: $durationOfPause)
            }
            Button("Add exercise to set") {
                let durationExercise = Double(durationOfExercise)
                let durationPause = Double(durationOfPause)
                
                if durationExercise != nil && durationPause != nil && durationExercise! > 0 && durationPause! > 0 && nameOfExercise != "" {
                    exerciseChooser.addInputToExerciseSet(name: nameOfExercise, duration: durationExercise!, pauseDuration: durationPause!)
                    nameOfExercise = ""
                    durationOfPause = ""
                    durationOfExercise = ""
                } else {
                    warningForWrongInput = true
                }
            }.alert("Wrong input/s!", isPresented: $warningForWrongInput) {
                
            }
            
            V_addedExerciseView()
                .environmentObject(exerciseChooser)
        }
    }
    
}

struct V_CreateExerciseView2_Previews: PreviewProvider {
    static var previews: some View {
        V_CreateExerciseView2()
    }
}
