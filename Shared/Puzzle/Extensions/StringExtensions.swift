//
//  StringExtensions.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 17/08/2022.
//

import Foundation

enum SpacePostions {
    case start
    case end
    case startAndEnd
}

extension String {
    
    var containsSpecialCharacter: Bool {
        let allowedChars = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]

        for letter in self {
            if allowedChars.contains(letter.lowercased()) == false {
                return true
            }
        }
        return false
    }
    
    func getBiggestWordSizeFromSentence(splitBy splittingChar: Character) -> Int {
        let words: [String] = self.split(separator: splittingChar).map({String($0)})
        return words.max(by: {$1.count > $0.count})?.count ?? 0
        
    }
    
    func getCharAsString(at index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)])
    }
    
    func removeSpaces(at position: SpacePostions) -> String {
        var result = self
        
        switch position {
        case .start:
            if self.first == " " {
                result.removeFirst()
                return result
            }
        case .end:
            if self.last == " " {
                result.removeLast()
                return result
            }
        case .startAndEnd:
            if self.first == " " {
                result.removeFirst()
            }
            
            if self.last == " " {
                result.removeLast()
            }
            
            return result
        }
        
        return result
    }
}
