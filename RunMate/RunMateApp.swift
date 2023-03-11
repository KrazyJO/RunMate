//
//  RunMateApp.swift
//  RunMate
//
//  Created by Jörn Otte on 19.02.23.
//

import SwiftUI

@main
struct RunMateApp: App {
    @State private var presentedViews: [TimerView] = []
    
    var body: some Scene {
        WindowGroup {
            NavigationStack() {
                // Einstiegsview: Setup, Kalender, Starten
                CreatorView()
            }
        }
    }
}
