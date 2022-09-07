//
//  UIColorExtensions.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 19/08/2022.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    @nonobjc class var appBlueColor: UIColor {
        return UIColor(named: "appBlueColor") ?? .clear
    }
    
    @nonobjc class var cornersColor: UIColor {
        return UIColor(named: "cornersColor") ?? .clear
    }
    
    @nonobjc class var keyboardColor: UIColor {
        return UIColor(named: "keyboardColor") ?? .clear
    }
    
    @nonobjc class var quizColor: UIColor {
        return UIColor(named: "quizColor") ?? .clear
    }
    
    @nonobjc class var winningColor: UIColor {
        return UIColor(named: "winningColor") ?? .clear
    }
    
    @nonobjc class var errorColor: UIColor {
        return UIColor(named: "errorColor") ?? .clear
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    @nonobjc static var firstGradientColor: Color {
        return Color(hex: "faf3dd")
    }
    
    @nonobjc static var secondGradientColor: Color {
        return Color(hex: "c8d5b9")
    }
    
    @nonobjc static var winningColor: Color {
        return Color(hex: "57B279")
    }
    
    @nonobjc static var losingColor: Color {
        return Color(hex: "C73E1D")
    }
}
