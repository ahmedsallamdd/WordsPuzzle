//
//  UIColorExtensions.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 19/08/2022.
//

import Foundation
import UIKit

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
}
