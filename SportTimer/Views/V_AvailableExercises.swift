//
//  V_AvaibleExercises.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 13.04.23.
//

import SwiftUI

struct V_AvailableExercises: View {
    
    @EnvironmentObject var exerciseChooser: ExerciseChooser
    
    var body: some View {
        ScrollView {
            ForEach(exerciseChooser.exerciseSets) { exerciseSet in
                Text(exerciseSet.name)
            }
        }
    }
}

struct V_AvaibleExercises_Previews: PreviewProvider {
    static var previews: some View {
        V_AvailableExercises()
    }
}
