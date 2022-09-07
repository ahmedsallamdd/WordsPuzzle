//
//  UIViewControllerExtensions.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 04/09/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showToastWithButton(message : String, buttonTitle: String) {
        
        // add label
        let toastLabel = UILabel(frame: CGRect(x: 30,
                                               y: self.view.frame.size.height-150,
                                               width: 330,
                                               height: 35))
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        
        //add button
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: toastLabel.frame.width - 50,
                                   y: toastLabel.frame.origin.y + 20,
                                   width: 40,
                                   height: 40)
        
        button.setTitle(buttonTitle, for: .normal)
        
        self.view.addSubview(toastLabel)
        self.view.addSubview(button)
        UIView.animate(withDuration: 4.0,
                       delay: 0.1,
                       options: .curveEaseOut,
                       animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
