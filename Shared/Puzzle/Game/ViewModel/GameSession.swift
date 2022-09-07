//
//  Session.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 07/09/2022.
//

import Foundation

class GameSession {
    static let shared = GameSession()
    
    var onQuizzesListIsReady: () -> Void = {}
    var onNextQuizReady: (Quiz) -> Void = {_ in}
    
    var currentQuiz = Quiz() {
        didSet {
            self.onNextQuizReady(currentQuiz)
        }
    }
    
    fileprivate var currentQuizIndex = -1
    fileprivate var quizList: [Quiz] = []
    fileprivate var service: DataLoadingProtocol
    
    private init() {
        self.service = QuizLoadingManager()
    }
    
    private func loadQuizzes() {
        self.service.fetchQuizzes(completion: { [weak self] quizzes in
            print("Quizzes Loaded Count:\n\(quizzes.count)")
            self?.quizList = quizzes.shuffled()
            self?.onQuizzesListIsReady()
            
        })
    }
    
    func getNextQuizIfAvailable() -> Quiz? {
        if self.quizList.count > 0 {
            return self.getNextQuiz()
        } else {
            self.loadQuizzes()
            return nil
        }
    }
    
    func getNextQuiz() -> Quiz {
        self.currentQuizIndex += 1
        
        if self.currentQuizIndex >= self.quizList.count {
            self.currentQuizIndex = 0
        }
        
        self.currentQuiz = self.quizList[self.currentQuizIndex]
        print(self.currentQuiz)
        return self.currentQuiz
    }
    
    
}
