//
//  Words_PuzzleApp.swift
//  Shared
//
//  Created by Ahmed Sallam on 14/08/2022.
//

import SwiftUI
import UIKit

@main
struct Words_PuzzleApp: App {
    
    let persistenceController = PersistenceController.shared
    let session = GameSession.shared
    
//    init() {
//        FirebaseApp.configure()
//    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

class AppState: ObservableObject {
    static let shared = AppState()
    private init() {}
    @Published var currentView : Views = .game
}

public enum Views {
    case game
    case result(QuizResult)
}
