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
