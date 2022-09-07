//
//  AnswerView.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 17/08/2022.
//

import UIKit
import SwiftUI

class QuizView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var categoryLabelContainerView: UIView!
    @IBOutlet var collectionViewContainerView: UIView!

//    @IBOutlet var hintLabel: UILabel!
    
    fileprivate var sectionsList: [String] = []
    fileprivate var selectedLetters: [String] = []
    fileprivate var shouldRevealFullAnswer = false
    fileprivate var currentItemSize: CGSize = .zero
    fileprivate var newFrame: CGRect = .zero
    
    fileprivate let nibName = "QuizView"
    fileprivate let player = SoundManager()
    
    var revealItems: (String) -> Void = { _ in }
    var revealFullAnswer: () -> Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func configure(with quiz: Quiz, newFrame: CGRect? = .zero) {
        self.newFrame = newFrame ?? .zero
        self.sectionsList = quiz.wordsList
        self.categoryLabel.text = quiz.category.capitalized
//        self.hintLabel.text = quiz.hint
        
        self.intializeCollectionView()
        
        self.revealItems = { [weak self] letter in
            self?.player.playCorrectAnswerSoundEffect()
            self?.selectedLetters.append(letter.lowercased())
            self?.collectionView.reloadData()
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        self.revealFullAnswer = {[weak self] in
            self?.shouldRevealFullAnswer = true
            self?.collectionView.reloadData()
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    fileprivate func commonInit() {
        self.contentView = self.loadViewFromNib(self.nibName)
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView.frame = self.bounds
        self.addSubview(self.contentView)
        
        self.collectionViewContainerView.roundCornersWithBorder(borderWidth: 1,
                                                                borderColor: .quizColor,
                                                                radius: 8)
        
        self.categoryLabelContainerView.roundCornersWithBorder(borderWidth: 0.5,
                                                               borderColor: .clear,
                                                               radius: 8)
    }

    fileprivate func intializeCollectionView() {
        let leftInset: CGFloat = 10
        let rightInset: CGFloat = 10
        let minInterItemSpacing: CGFloat = 5
        let biggestWordCount: CGFloat = CGFloat(self.sectionsList.max(by: {$1.count > $0.count})?.count ?? 2)
        
        var itemDimension = (self.newFrame.width - leftInset - rightInset
                             - ((biggestWordCount - 1) * minInterItemSpacing)) / (biggestWordCount + 1)
        
        
        // so small words would have an item size cap.
        if itemDimension > 35 {
            itemDimension = 35
        }
        
        self.currentItemSize = CGSize(width: itemDimension, height: itemDimension)
        print("quiz item size: \(self.currentItemSize)")
        let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        let layout = FlowLayout(itemSize: self.currentItemSize,
                                minimumInteritemSpacing: minInterItemSpacing,
                                minimumLineSpacing: 10,
                                sectionInset: sectionInsets)
        
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(QuizCollectionViewCell.self,
                                     forCellWithReuseIdentifier: QuizCollectionViewCell.identifier)
        
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.clear
    }
}

extension QuizView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let cell = collectionView.cellForItem(at: indexPath) as? QuizCollectionViewCell
//        cell?.contentView.frame = cell?.bounds ?? .zero
//        cell?.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        let itemSize = self.currentItemSize
//
//        return itemSize
//
//    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return self.sectionsList[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizCollectionViewCell.identifier,
                                                         for: indexPath) as? QuizCollectionViewCell {
            
            let currentLetter = self.sectionsList[indexPath.section].getCharAsString(at: indexPath.row)
            cell.configure(with: currentLetter)
            
            if self.shouldRevealFullAnswer == true {// Reveal all letters
                if currentLetter != "" && currentLetter != " " {
                    UIView.transition(with: cell.contentView,
                                      duration: 1,
                                      options: [.curveEaseIn, .transitionCrossDissolve],
                                      animations: {
                        cell.contentView.backgroundColor = .errorColor
                        
                    },completion: nil)
                    
                    cell.revealAnswer()
                }
                
            } else {
                
                // reveal all items that contains a selected letter
                if self.selectedLetters.contains(currentLetter.lowercased()) {
                    cell.revealAnswer()
                }
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
}

struct QuizViewWrapper : UIViewRepresentable {
    var quizView  = QuizView(frame: .zero)
    
    func makeUIView(context: Context) -> QuizView {
        return quizView
    }
    
    func updateUIView(_ uiView: QuizView, context: Context) {
        
    }
    
    typealias UIViewType = QuizView
}

extension QuizViewWrapper {
    
    func revealItems(letter : String) {
        self.quizView.revealItems(letter)
    }
    
    func revealFullAnswer() {
        self.quizView.revealFullAnswer()
    }
    
    func configure(with quiz: Quiz, newFrame: CGSize) {
        self.quizView.configure(with: quiz, newFrame: CGRect(origin: CGPoint(x: 0, y: 0), size: newFrame))
    }
}
