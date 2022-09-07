//
//  MainView.swift
//  Words Puzzle (iOS)
//
//  Created by Ahmed Sallam on 07/09/2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var appState = AppState.shared

    var body: some View {
        ZStack {
            GeometryReader { metrics in

                let gradient = Gradient(colors: [.firstGradientColor, .secondGradientColor])
                LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .topTrailing)
                    .ignoresSafeArea()
                
                switch appState.currentView {
                case .game:
                    GameView(viewModel: GameSessionViewModel(), metrics: metrics)
                        .ignoresSafeArea(edges: .bottom)
                    
                case .result(let result):
                    ResultView(result: result)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
