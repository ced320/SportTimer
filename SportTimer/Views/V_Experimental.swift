//
//  V_Experimental.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 02.08.23.
//

import SwiftUI

struct CircularProgressView: View {

    @EnvironmentObject var exerciseSetStorage: MVC_ExerciseStorage
    @Binding var progress: Float
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            withAnimation
        }
    
    var withAnimation: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 16.0)
                .opacity(0.1)
                .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 16.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(exerciseSetStorage.getThemeColors(type: .primary, colorScheme: colorScheme))
            // Ensures the animation starts from 12 o'clock
                .rotationEffect(Angle(degrees: 270))
        }
        // The progress animation will animate over 1 second which
        // allows for a continuous smooth update of the ProgressView
        .animation(.linear(duration: Double(1/Double(animationConstants.multiplicationTimeFactor))+animationConstants.animationEpsilon), value: progress)
        
    }
}


struct BindingView : View {
    @State private var progress:Float = 0.5
    @State private var progressOld:Float = 0.3
    
    var body: some View {
        CircularProgressView(progress: $progress)
    }
}
struct V_Experimental_Previews: PreviewProvider {
    static var previews: some View {
        BindingView()
    }
}
