//
//  KeyboardView.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 15/08/2022.
//

import Foundation
import UIKit

class KeyboardViewModel {
    let lettersOptions = ["A", "B", "C", "D", "E", "F", "G",
                          "H", "I", "J", "K", "L", "M", "N",
                          "O", "P", "Q", "R", "S", "T", "U",
                          "V", "W", "X", "Y", "Z"]
}

class KeyboardView: UIView {
    
    fileprivate var collectionView: UICollectionView!
    fileprivate var viewModel = KeyboardViewModel()
    var keyTappedAction: (String) -> Void = { _ in }
    
    init(frame: CGRect, onKeyTapped: @escaping (String) -> Void) {
        self.keyTappedAction = onKeyTapped
        super.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    func loadData() {
        self.collectionView.reloadData()
    }
    
    fileprivate func commonInit() {
        self.intializeCollectionView()
    }
    
    fileprivate func intializeCollectionView() {
        
        let itemDimension = self.frame.width / 10
        let itemSize = CGSize(width: itemDimension, height: itemDimension)
        
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 30)
        
        let layout = FlowLayout(itemSize: itemSize,
                                minimumInteritemSpacing: 10,
                                minimumLineSpacing: 10,
                                sectionInset: insets)
        
        self.collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(KeyboardCollectionViewCell.self,
                                     forCellWithReuseIdentifier: KeyboardCollectionViewCell.identifier)
        
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.backgroundColor = UIColor.white
        self.addSubview(self.collectionView)
    }
    
}

extension KeyboardView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.lettersOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyboardCollectionViewCell.identifier, for: indexPath) as? KeyboardCollectionViewCell {
            
            cell.configure(with: self.viewModel.lettersOptions[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.keyTappedAction(self.viewModel.lettersOptions[indexPath.row])
    }
    
}

class FlowLayout: UICollectionViewFlowLayout {

    required init(itemSize: CGSize,
                  minimumInteritemSpacing: CGFloat = 0,
                  minimumLineSpacing: CGFloat = 0,
                  sectionInset: UIEdgeInsets = .zero) {
        
        super.init()

        self.itemSize = itemSize
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
        self.sectionInsetReference = .fromContentInset
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        guard scrollDirection == .vertical else { return layoutAttributes }

        // Filter attributes to compute only cell attributes
        let cellAttributes = layoutAttributes.filter({ $0.representedElementCategory == .cell })

        // Group cell attributes by row (cells with same vertical center) and loop on those groups
        for (_, attributes) in Dictionary(grouping: cellAttributes, by: { ($0.center.y / 10).rounded(.up) * 10 }) {
            // Get the total width of the cells on the same row
            let cellsTotalWidth = attributes.reduce(CGFloat(0)) { (partialWidth, attribute) -> CGFloat in
                partialWidth + attribute.size.width
            }

            // Calculate the initial left inset
            let totalInset = collectionView!.safeAreaLayoutGuide.layoutFrame.width - cellsTotalWidth - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(attributes.count - 1)
            var leftInset = (totalInset / 2 * 10).rounded(.down) / 10 + sectionInset.left

            // Loop on cells to adjust each cell's origin and prepare leftInset for the next cell
            for attribute in attributes {
                attribute.frame.origin.x = leftInset
                leftInset = attribute.frame.maxX + minimumInteritemSpacing
            }
        }

        return layoutAttributes
    }

}
