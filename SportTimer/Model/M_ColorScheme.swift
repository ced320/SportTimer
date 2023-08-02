//
//  M_ColorScheme.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 31.07.23.
//

import Foundation
import SwiftUI

struct M_ColorScheme {
    
//    private let primaryColor: Color = Color(hex: 0x3B5BA5) //dark blue
//    private let secondaryColor: Color = Color(hex: 0xF4E409) // yellow
//    private let backgroundColor: Color = Color(hex: 0xE87A5D) // orange
//    private let warningColor: Color = .red
    
//    private let primaryColor: Color = Color(hex: 0xFF00FF) // magenta
//    private let secondaryColor: Color = Color(hex: 0xFFD700) // gold
//    private let backgroundColor: Color = Color(hex: 0xFFFFFF)//Color(hex: 0x008080) //blue green
//    private let warningColor: Color = .red
//    private let primaryColorNight: Color = Color(hex: 0xFFD700) // magenta
//    private let secondaryColorNight: Color = Color(hex: 0xFF00FF) // gold
//    private let backgroundColorNight: Color = Color(hex: 0x000000)//Color(hex: 0x008080) //blue green
    
    private let primaryColor: Color = Color(hex: 0x0e3a53) // magenta
    private let secondaryColor: Color = Color(hex: 0xcfffe5) // gold
    private let backgroundColor: Color = Color(hex: 0xFFFFFF)//Color(hex: 0x008080) //blue green
    private let warningColor: Color = .red
    private let primaryColorNight: Color = Color(hex: 0xcfffe5) // magenta
    private let secondaryColorNight: Color = Color(hex: 0x0e3a53) // gold
    private let backgroundColorNight: Color = Color(hex: 0x000000)//Color(hex: 0x008080) //blue green
    
    func giveColor(typeOfColor type: TypeOfColor, darkMode: ColorScheme) -> Color {
        switch (type,darkMode) {
        case (.primary, .light):
            return primaryColor
        case (.secondary, .light):
            return secondaryColor
        case (.background,.light):
            return backgroundColor
        case (.warning,.light):
            return warningColor
        case (.primary, .dark):
            return primaryColorNight
        case (.secondary, .dark):
            return secondaryColorNight
        case (.background,.dark):
            return backgroundColorNight
        case (.warning,.dark):
            return warningColor
        case (_, _):
            return .red
        }
    }
}
    

enum TypeOfColor {
    case primary, secondary, background, warning
}
