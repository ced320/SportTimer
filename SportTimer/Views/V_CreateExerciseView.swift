//
//  V_CreateExerciseView2.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 15.04.23.
//

import SwiftUI

struct V_CreateExerciseView2: View {
    
    @EnvironmentObject var exerciseChooser: ExerciseChooser
    @EnvironmentObject var exerciseCreate: MVC_ExerciseCreate
    
    var body: some View {
        VStack {
            List {
                //TextField("Name", text: $exerciseChooser.name)
                Text("GiveName")
                Text("name of exercise")
                Text("duration in seconds")
                Text("isPause").onTapGesture {
                    exerciseCreate.testPrint()
                }
            }
            Button("Add exercise to set") {
                exerciseCreate.testPrint()
            }
        }
    }
}

struct V_CreateExerciseView2_Previews: PreviewProvider {
    static var previews: some View {
        V_CreateExerciseView2()
    }
}
