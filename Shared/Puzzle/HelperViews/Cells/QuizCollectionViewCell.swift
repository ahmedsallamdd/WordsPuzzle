//
//  AnswerViewCollectionViewCell.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 17/08/2022.
//

import UIKit

class QuizCollectionViewCell: UICollectionViewCell {
    fileprivate(set) var letterLabel: UILabel!
    fileprivate(set) var letter: String = ""
        
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
        self.letter = letter
        self.letterLabel.text = letter.uppercased()
        self.letterLabel.textColor = .clear

        if letter == " " {
            self.contentView.backgroundColor = .clear
        } else {
            self.contentView.backgroundColor = .quizColor
        }
    }
    
    func revealAnswer() {
        self.letterLabel.textColor = .white
    }
    
    func revealAnswerWithLossAnimation() {
        self.letterLabel.text = self.letter.uppercased()
    }
    
    fileprivate func setupUI() {
        self.contentView.autoresizingMask = .flexibleWidth
        self.contentView.backgroundColor = .quizColor
        
        self.letterLabel = UILabel(frame: self.contentView.bounds)
        self.letterLabel.backgroundColor = .clear
        self.letterLabel.textColor = .white
        self.letterLabel.textAlignment = .center
        self.letterLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        if self.letter != " " && self.letter != "" && self.letter.containsSpecialCharacter == true {
            self.revealAnswer()
        }
        
        if self.letter != "" && self.letter != " " {
            self.contentView.roundCornersWithBorder(borderWidth: 2,
                                                    borderColor: .cornersColor,
                                                    radius: 8)
        } else {
            self.contentView.roundCornersWithBorder(borderWidth: 2,
                                                    borderColor: .clear,
                                                    radius: 8)
            
        }
    }
    
    fileprivate func addSubViews() {
        self.contentView.addSubview(self.letterLabel)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
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
