//
//  V_Experimental.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 02.08.23.
//

import SwiftUI

struct V_Experimental: View {


    let duration: TimeInterval = 5
    @State var start: CGFloat = 0
    @State var end: CGFloat = 0
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: start, to: end)
                .stroke(LinearGradient(gradient: Gradient(colors: [.blue, .red]),
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing),
                        style: .init(lineWidth: 4, lineCap: .round))
                .frame(width: 320, height: 320)
                
            Spacer()
        }.onAppear {
            Timer.scheduledTimer(withTimeInterval: self.duration,  // Fill Timer
                                 repeats: true) { _ in
                self.start = 0
                self.end = 0
                withAnimation(.linear(duration: self.duration/2)) {
                    self.end = 1
                }
            }.fire()
            Timer.scheduledTimer(withTimeInterval: self.duration/2,  // Delay Timer
                                 repeats: false) { _ in
                Timer.scheduledTimer(withTimeInterval: self.duration,  // Clear Timer
                                     repeats: true) { _ in
                    withAnimation(.linear(duration: 0.1)) {
                        self.start = 1
                    }
                }.fire()
            }
        }
        
    }
}



struct V_Experimental_Previews: PreviewProvider {
    static var previews: some View {
        V_Experimental()
    }
}
