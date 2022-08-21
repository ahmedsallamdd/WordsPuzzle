//
//  GameViewModel.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 16/08/2022.
//

import Foundation

struct Quiz {
    let content: String
    let category: String
    let hint: String
    var wordsList: [String] {
        let words: [String] = self.content.split(separator: " ").map({String($0)})
        let biggestWordLength = words.max(by: {$1.count > $0.count})?.count ?? 0
        
        return self.constructWordsListAccordingToLongestWordInQuiz(maxLength: biggestWordLength, wordsList: words)
    }
    
    init() {
        self.content = ""
        self.category = ""
        self.hint = ""
    }
    
    init(content: String, category: String, hint: String) {
        self.content = content
        self.category = category
        self.hint = hint
    }
    
    private func constructWordsListAccordingToLongestWordInQuiz(maxLength: Int, wordsList: [String]) -> [String] {
        var sectionsList = [String]()
        
        let currentIndex = 0
        var result = wordsList[currentIndex]
        var currentLength = result.count
        
        var nextIndex = currentIndex + 1
        
        while (nextIndex < wordsList.count) {
            if (currentLength + wordsList[nextIndex].count) <= maxLength {
                result = result + " " + wordsList[nextIndex]
                currentLength = result.count
                nextIndex += 1
                print(result)
                
            } else {
                sectionsList.append(result.removeSpaces(at: .startAndEnd))
                result = ""
                currentLength = 0
            }
        }
        
        sectionsList.append(result.removeSpaces(at: .startAndEnd))
        
        return sectionsList
    }
}

/*
 The flow of the app should be like the following:
    - When the GameVC is created, a quiz should be randomly selected of some sort of quiz list.
    - Generate QuizView with keys of its content count.
    - When a key is tapped, the GameViewModel should be notified.
        - if the answer is correct, it should update the quiz view.
        - If it's not correct update, the number of trials view.
 */

class GameViewModel {
    private var selectedLetters = [String]()
    private var currentNumberOfMistakes = 0
    
    // for now we create a static quiz.
    var quiz = Quiz(content: "once upon a time in hollywood",
                    category: "Movie",
                    hint: "A movie written and produced by Quentin Tarantino")
    
    var maxNumberOfTrials = 4

    var revealItemsWithLetter: (String) -> Void = {_ in}
    var incrementErrors: () -> Void = {}
    
    var onPlayerWin: () -> Void = {}
    var onPlayerLose: () -> Void = {}

    func handleKeyTap(for letter: String) {
        if self.selectedLetters.contains(letter.lowercased()) == true {
            print("\(letter) has been already selected!")
            
        } else {
            self.selectedLetters.append(letter)
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
    
    fileprivate func checkIfPlayerWon() {
        for letter in self.quiz.content {
            if self.selectedLetters.contains(String(letter)) == false {
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
