//
//  V_CreateNewExerciseView.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 10.04.23.
//

import SwiftUI

struct CreateNewExerciseView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                NavigationLink("Start Exercise") {
                    Text("Hey")
                }
                Spacer()
                NavigationLink("Select Exercise") {
                    Text("Hey")
                }
                Spacer()
                NavigationLink("Create Exercise") {
                    Text("Hey")
                }
                Spacer()
            }
            .navigationTitle("Sportstimer")
        }
    }
}

struct CreateNewExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewExerciseView()
    }
}
