//
//  UIViewExtensions.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 19/08/2022.
//

import Foundation
import UIKit

extension UIView {
    func loadViewFromNib(_ nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    func roundCornersWithBorder(borderWidth: CGFloat, borderColor: UIColor, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
}
