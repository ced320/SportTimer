//
//  V_addedExerciseView.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 20.04.23.
//

import SwiftUI

struct V_addedExerciseView: View {
    
    @EnvironmentObject var exerciseChooser: MVC_ExerciseStorage
    @EnvironmentObject var builder: MVC_CreateExerciseSet
    
    var body: some View {
        ScrollView {
            ForEach(builder.exerciseSetBuilder.exerciseSetThatShallBeAdded) { exercise in
                VStack {
                    Text(exercise.name)
                }
            }
        }
    }
}

struct V_addedExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        V_addedExerciseView()
            .environmentObject(MVC_ExerciseStorage(named: "exerciseChooser"))
    }
}
