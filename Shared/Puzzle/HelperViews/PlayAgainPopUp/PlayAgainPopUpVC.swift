//
//  PlayAgainPopUpVC.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 01/09/2022.
//

import UIKit

class PlayAgainPopUpVC: UIViewController {

    @IBOutlet weak var blurVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var checkImageContainerView: UIView!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var playAgainButton: UIButton!
    
    fileprivate let checkMarkImageTitle = "checkmark.circle.fill"
    fileprivate let xMarkImageTitle = "xmark.circle.fill"
    fileprivate var isForWinning: Bool = false
    
    static func create(isForWin: Bool) -> PlayAgainPopUpVC {
        let vc = PlayAgainPopUpVC(nibName: "PlayAgainPopUpVC", bundle: nil)
        vc.isForWinning = isForWin
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    fileprivate func setupUI() {
        self.alertView.roundCornersWithBorder(borderWidth: 1,
                                              borderColor: .clear,
                                              radius: 8)
        
        self.checkImageContainerView.roundCornersWithBorder(borderWidth: 1,
                                                           borderColor: .white,
                                                           radius: 30)
        
        self.playAgainButton.layer.cornerRadius = 8
        self.playAgainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        self.blurVisualEffectView.effect = UIBlurEffect(style: .dark)
        
        self.fillAlertData(isWinningCase: self.isForWinning)
    }
    
    fileprivate func fillAlertData(isWinningCase: Bool) {
        if isWinningCase {
            self.messageLabel.text = "Congratulations!\n\n🎉🎉🎉You've Won🎉🎉🎉"
            self.checkMarkImageView.image = UIImage(systemName: self.checkMarkImageTitle)
            self.checkMarkImageView.tintColor = .winningColor
            self.playAgainButton.backgroundColor = .winningColor
            
        } else {
            self.messageLabel.text = "Game over".capitalized
            self.checkMarkImageView.image = UIImage(systemName: self.xMarkImageTitle)
            self.checkMarkImageView.tintColor = .errorColor
            self.playAgainButton.backgroundColor = .errorColor
        }
    }
    
    @IBAction func onPlayAgainButtonClicked(_ sender: UIButton) {
//        AppState.shared.reloadGameView.toggle()
        self.dismiss(animated: true)
    }
}
