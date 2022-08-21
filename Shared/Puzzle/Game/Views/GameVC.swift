//
//  GameVC.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 15/08/2022.
//

import UIKit
import SwiftUI

class GameVC: UIViewController {

    @IBOutlet weak var keyboardView: KeyboardView!
    @IBOutlet weak var quizView: QuizView!
    @IBOutlet weak var errorTrialsView: ErrorTrailsView!
    
    fileprivate var viewModel: GameViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindWithViewModel()
        self.setupKeyboardView()
        self.setupQuizView()
        self.setupErrorTrialsView()
    }
    
    fileprivate func bindWithViewModel() {
        self.viewModel = GameViewModel()
        self.viewModel.onPlayerWin = {
            self.showAlert(title: "Congratulations!", message: "You fuckin' won bro🎉🎉🎉")
        }
        
        self.viewModel.onPlayerLose = {
            self.showAlert(title: "Oops!", message: "You fuckin' lost mate💔💔💔")
        }
    }
    
    fileprivate func setupKeyboardView() {
        self.keyboardView.loadData()
        self.keyboardView.keyTappedAction = { [weak self] letter in
            self?.viewModel.handleKeyTap(for: letter)
        }
    }
    
    fileprivate func setupQuizView() {
        self.quizView.configure(with: self.viewModel.quiz)
        self.viewModel.revealItemsWithLetter = { [weak self] letter in
            self?.quizView.revealItems(letter)
        }
    }
    
    fileprivate func setupErrorTrialsView() {
        self.errorTrialsView.configure(maxNumberOfTrials: self.viewModel.maxNumberOfTrials)
        self.viewModel.incrementErrors = { [weak self] in
            self?.errorTrialsView.onSelectionError()
        }
    }
    
    fileprivate func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true, completion: nil)
        })
    }
}

struct GameViewController: UIViewControllerRepresentable {
        
    func makeUIViewController(context: Context) -> some UIViewController {
        return GameVC(nibName: "GameVC", bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
