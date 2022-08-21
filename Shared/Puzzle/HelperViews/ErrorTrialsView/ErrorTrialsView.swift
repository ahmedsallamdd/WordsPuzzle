//
//  ErrorTrialsView.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 19/08/2022.
//

import Foundation
import UIKit

class ErrorTrailsView: UIView {
    fileprivate var errorImagesStackView: UIStackView!
    
    fileprivate var maxNumberOfTrials: Int = 4
    fileprivate var currentNumberOfMistakes: Int = 0
    fileprivate let errorImageName = "clear.fill"
    
    var onSelectionError: () -> Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func configure(maxNumberOfTrials: Int) {
        self.maxNumberOfTrials = maxNumberOfTrials
        self.onSelectionError = { [weak self] in
            if let self = self {
                let imageView = self.errorImagesStackView.arrangedSubviews[self.currentNumberOfMistakes] as! UIImageView
                imageView.tintColor = .red
                self.currentNumberOfMistakes += 1
            }
        }
    }
    
    fileprivate func commonInit() {
        self.initStackView()
    }
    
    fileprivate func initStackView() {
        self.errorImagesStackView = UIStackView(frame: self.bounds)
        self.errorImagesStackView.alignment = .fill
        self.errorImagesStackView.axis = .horizontal
        self.errorImagesStackView.distribution = .fillEqually
        
        for _ in stride(from: self.currentNumberOfMistakes, to: self.maxNumberOfTrials, by: 1) {
            let image = UIImage(systemName: self.errorImageName)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .gray
            self.errorImagesStackView.addArrangedSubview(imageView)
        }
        
        self.addSubview(errorImagesStackView)
        self.errorImagesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.errorImagesStackView.trailingAnchor
            .constraint(equalTo: self.trailingAnchor,constant: 0).isActive = true
        
        self.errorImagesStackView.leadingAnchor
            .constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
        
        self.errorImagesStackView.topAnchor
            .constraint(equalTo: self.topAnchor,constant: 10).isActive = true
        
        self.errorImagesStackView.bottomAnchor
            .constraint(equalTo: self.bottomAnchor,constant: 10).isActive = true
    }
}
