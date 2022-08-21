//
//  Words_PuzzleApp.swift
//  Shared
//
//  Created by Ahmed Sallam on 14/08/2022.
//

import SwiftUI

@main
struct Words_PuzzleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            GameViewController()
            
//            PuzzleMainView(viewModel: PuzzleViewModel())
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
