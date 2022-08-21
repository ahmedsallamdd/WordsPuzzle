//
//  KeyboardCollectionViewCell.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 15/08/2022.
//

import UIKit

class KeyboardCollectionViewCell: UICollectionViewCell {
    fileprivate var letterLabel: UILabel!
    
    public var isTappedAlready = false
    public static let identifier = "KeyboardCollectionViewCell"
    
    func configure(with letter: String) {
        self.letterLabel.text = letter
    }
    
    func tap() {
        if self.isTappedAlready == false {
            self.isTappedAlready.toggle()
            self.letterLabel.backgroundColor = .darkGray
        }
    }
    
    override var isSelected: Bool {
        willSet {
            super.isSelected = newValue
            if newValue == true {
                self.tap()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        self.setupUI()
        self.addSubViews()
    }
    
    fileprivate func setupUI() {
        self.letterLabel = UILabel(frame: self.bounds)
        self.letterLabel.backgroundColor = self.isTappedAlready ? .darkGray : .keyboardColor
        self.letterLabel.textColor = .white
        self.letterLabel.textAlignment = .center
        self.letterLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
    
    fileprivate func addSubViews() {
        self.addSubview(self.letterLabel)
        let topConstraint = NSLayoutConstraint(item: self.contentView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self.letterLabel,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.contentView,
                                               attribute: .bottom,
                                               relatedBy: .equal,
                                               toItem: self.letterLabel,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: self.contentView,
                                               attribute: .leading,
                                               relatedBy: .equal,
                                               toItem: self.letterLabel,
                                               attribute: .leading,
                                               multiplier: 1,
                                               constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: self.contentView,
                                               attribute: .trailing,
                                               relatedBy: .equal,
                                               toItem: self.letterLabel,
                                               attribute: .trailing,
                                               multiplier: 1,
                                               constant: 0)
        
        self.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }
}
