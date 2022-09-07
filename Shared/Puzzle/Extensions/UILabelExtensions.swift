//
//  UILabelExtensions.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 22/08/2022.
//

import UIKit

extension UILabel {
    func animate(font: UIFont, duration: TimeInterval) {
        // let oldFrame = frame
        let labelScale = self.font.pointSize / font.pointSize
        self.font = font
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        // let newOrigin = frame.origin
        // frame.origin = oldFrame.origin // only for left aligned text
        // frame.origin = CGPoint(x: oldFrame.origin.x + oldFrame.width - frame.width, y: oldFrame.origin.y) // only for right aligned text
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            //L self.frame.origin = newOrigin
            self.transform = oldTransform
            self.layoutIfNeeded()
        }
    }
}
