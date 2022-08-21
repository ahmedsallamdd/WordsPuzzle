//
//  GameViewModel.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 16/08/2022.
//

import Foundation

class GameViewModel {
    private var selectedLetters = [String]()
    
    func handleKeyTap(for letter: String) {
        if self.selectedLetters.contains(letter) == true {
            print("\(letter) has been already selected!")
            
        } else {
            self.selectedLetters.append(letter)
            print("\(letter) is tapped!")
        }
    }
    
}
