//
//  AnswerViewCollectionViewCell.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 17/08/2022.
//

import UIKit

class QuizCollectionViewCell: UICollectionViewCell {
    fileprivate var letterLabel: UILabel!
    fileprivate var letter: String = ""
    
    var isRevealed: Bool = false
    
    public static let identifier = "QuizCollectionViewCell"
    
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
    
    func configure(with letter: String) {
        if letter == " " {
            self.letterLabel.textColor = .clear
            self.letterLabel.backgroundColor = .clear
            return
        }
        self.letter = letter
        self.letterLabel.text = ""
    }
    
    func revealAnswer() {
        self.isRevealed = true
        self.letterLabel.text = self.letter.uppercased()
    }
    
    fileprivate func setupUI() {
        self.letterLabel = UILabel(frame: self.bounds)
        self.letterLabel.backgroundColor = .quizColor
        self.letterLabel.textColor = .white
        self.letterLabel.textAlignment = .center
        self.letterLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
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
