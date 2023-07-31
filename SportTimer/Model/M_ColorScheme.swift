//
//  M_ColorScheme.swift
//  SportTimer
//
//  Created by Cedric Frimmel-Hoffmann on 31.07.23.
//

import Foundation
import SwiftUI

struct M_ColorScheme {
    private let primaryColor: Color = Color(hex: 0x3B5BA5) //dark blue
    private let secondaryColor: Color = Color(hex: 0xF4E409) // yellow
    private let backgroundColor: Color = Color(hex: 0xE87A5D) // orange
    private let warningColor: Color = .red
    
    func giveColor(typeOfColor type: TypeOfColor) -> Color {
        switch type {
        case .primary:
            return primaryColor
        case .secondary:
            return secondaryColor
        case .background:
            return backgroundColor
        case .warning:
            return warningColor
        }
    }
}

enum TypeOfColor {
    case primary, secondary, background, warning
}
