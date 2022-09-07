//
//  GameView.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 04/09/2022.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameSessionViewModel
    let metrics : GeometryProxy
    
    let errorView = ErrorTrailsViewWrapper()
    let quizView = QuizViewWrapper()
    
    var body: some View {
        
        VStack(alignment: .center) {
            //                ScoreView()
            //                    .frame(height: metrics.size.height * 0.1)
            
            self.errorView
                .frame(height: metrics.size.height * 0.2)
            
            let quizViewFrame = CGSize(width: metrics.size.width, height: metrics.size.height * 0.4)
            self.quizView
                .frame(height: quizViewFrame.height)
                .onAppear {
                    self.viewModel.loadData()
                    self.quizView.configure(with: self.viewModel.quiz, newFrame: quizViewFrame)
                }
            
            let keyboardFrame = CGSize(width: metrics.size.width, height: metrics.size.height * 0.28)
            KeyboardViewWrapper(frame: keyboardFrame, onKeyTapped: {letter in
                self.viewModel.handleKeyTap(for: letter)
            })
            .frame(height: keyboardFrame.height)
            
        }
        .onAppear {
            self.viewModel.revealItemsWithLetter = { letter in
                self.quizView.revealItems(letter: letter)
            }
            
            self.errorView.configure(maxNumberOfTrials: self.viewModel.maxNumberOfTrials)
            self.viewModel.incrementErrors = {
                self.errorView.wrongLetterHasBeenSelected()
            }
            
            self.viewModel.onPlayerLose = {
                self.quizView.revealFullAnswer()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    AppState.shared.currentView = .result(.lose)
                }
            }
            
            self.viewModel.onPlayerWin = {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    AppState.shared.currentView = .result(.win)
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { metrics in
            GameView(viewModel: GameSessionViewModel(), metrics: metrics)
        }
    }
}
