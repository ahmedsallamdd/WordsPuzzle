//
//  GameVC.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 15/08/2022.
//

import UIKit
import SwiftUI

class GameViewModel {
    private var selectedLetters = [String]()
    
    func onKeyTapped(_ letter: String) {
        if self.selectedLetters.contains(letter) == true {
            print("\(letter) has been already selected!")
            
        } else {
            self.selectedLetters.append(letter)
            print("\(letter) is tapped!")
        }
    }
    
}

class GameVC: UIViewController {

    @IBOutlet weak var keyboardView: KeyboardView!
    
    let viewModel: GameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.keyboardView.keyTappedAction = { [weak self] letter in
            self?.viewModel.onKeyTapped(letter)
        }
        self.keyboardView.loadData()
    }
}

struct GameViewController: UIViewControllerRepresentable {
        
    func makeUIViewController(context: Context) -> some UIViewController {
        return GameVC(nibName: "GameVC", bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
