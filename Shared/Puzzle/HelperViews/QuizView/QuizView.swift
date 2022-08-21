//
//  AnswerView.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 17/08/2022.
//

import UIKit

class QuizView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var categoryLabelContainerView: UIView!
    @IBOutlet var collectionViewContainerView: UIView!

    @IBOutlet var hintLabel: UILabel!
    
    fileprivate var sectionsList: [String] = []
    fileprivate var selectedLetters: [String] = []
    fileprivate let nibName = "QuizView"
    
    var revealItems: (String) -> Void = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func configure(with quiz: Quiz) {
        self.sectionsList = quiz.wordsList
        self.categoryLabel.text = quiz.category
        self.hintLabel.text = quiz.hint
        self.intializeCollectionView()
        
        self.revealItems = { [weak self] letter in
            self?.selectedLetters.append(letter.lowercased())
            self?.collectionView.reloadData()
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
        
        let itemDimension = (self.collectionView.frame.width - leftInset - rightInset - ((biggestWordCount - 1) * minInterItemSpacing)) / (biggestWordCount + 1 )
        
        let itemSize = CGSize(width: itemDimension, height: itemDimension)
        
        let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        let layout = FlowLayout(itemSize: itemSize,
                                minimumInteritemSpacing: minInterItemSpacing,
                                minimumLineSpacing: 10,
                                sectionInset: sectionInsets)
        
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(QuizCollectionViewCell.self,
                                     forCellWithReuseIdentifier: QuizCollectionViewCell.identifier)
        
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.white
    }
}

extension QuizView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sectionsList[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizCollectionViewCell.identifier, for: indexPath) as? QuizCollectionViewCell {
            
            let currentLetter = self.sectionsList[indexPath.section].getCharAsString(at: indexPath.row)
            cell.configure(with: currentLetter)
            
            // reveal all items that contains a selected letter
            if self.selectedLetters.contains(currentLetter.lowercased()) {
                cell.revealAnswer()
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
}
