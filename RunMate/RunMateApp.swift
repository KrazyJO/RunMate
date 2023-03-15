//
//  RunMateApp.swift
//  RunMate
//
//  Created by Jörn Otte on 19.02.23.
//

import SwiftUI

@main
struct RunMateApp: App {
    @StateObject var navigataionPath = NavigationPath()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigataionPath.path) {
                // Einstiegsview: Setup, Kalender, Starten
                CreatorView()
                    .navigationDestination(for: Routes.self) { view in
                        switch view {
                        case .timer(let definition):
                            TimerView(definition: definition)
                        case .preparation(let definition):
                            PreparationView(duration: definition.preparation, counter: definition.preparation, definition: definition)
                        }
                    }
            }
            .environmentObject(navigataionPath)
        }
    }
}
