//
//  QuizModel.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 23/08/2022.
//

import Foundation

struct Quiz: Codable {
    let content: String
    let category: String
    let hint: String?
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
    
    init(content: String, category: String, hint: String?) {
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
