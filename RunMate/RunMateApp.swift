//
//  RunMateApp.swift
//  RunMate
//
//  Created by Jörn Otte on 19.02.23.
//

import SwiftUI

@main
struct RunMateApp: App {
    var body: some Scene {
        WindowGroup {
            let definition = TimerDefinition(preparation: 20, workout: 120, pause: 30, rounds: 4)
            TimerView(definition: definition)
        }
    }
}
