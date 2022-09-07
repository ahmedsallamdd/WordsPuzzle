//
//  GameSessionViewModel.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 04/09/2022.
//

import Foundation

class GameSessionViewModel: ObservableObject {
    private let session = GameSession.shared
    private var selectedLetters = [String]()
    private var currentNumberOfMistakes = 0
    
    @Published fileprivate(set) var quiz = Quiz()
    
    var maxNumberOfTrials = 4

    var revealItemsWithLetter: (String) -> Void = {_ in}
//    var revealFullAnswer: () -> Void = {}
    var incrementErrors: () -> Void = {}
    
    var onQuizReady: () -> Void = {}
    var onPlayerWin: () -> Void = {}
    var onPlayerLose: () -> Void = {}
    
    
    init() {
        self.session.onQuizzesListIsReady = {[weak self] in
            self?.quiz = GameSession.shared.getNextQuiz()
        }
    }
    
    func loadData() {
        if let quiz = self.session.getNextQuizIfAvailable() {
            self.quiz = quiz
        }
    }
    
    func handleKeyTap(for letter: String) {
        if self.selectedLetters.contains(letter.lowercased()) == true {
            print("\(letter) has been already selected!")
            
        } else {
            self.selectedLetters.append(letter.lowercased())
            print("\(letter) is tapped!")
            
            if self.quiz.content.lowercased().contains(letter.lowercased()) {
                self.revealItemsWithLetter(letter)
                self.checkIfPlayerWon()

            } else {
                self.incrementErrors()
                self.currentNumberOfMistakes += 1
                self.checkIfPlayerLost()
            }
        }
    }
    
    func playAgain() {
//        AppState.shared.reloadGameView.toggle()
    }
    
    fileprivate func checkIfPlayerWon() {
        for letter in self.quiz.content.lowercased() {
            if letter != " " && self.selectedLetters.contains(String(letter).lowercased()) == false {
                return
            }
        }
        self.onPlayerWin()
    }
    
    fileprivate func checkIfPlayerLost() {
        if self.currentNumberOfMistakes == self.maxNumberOfTrials {
            self.onPlayerLose()
        }
    }
}
