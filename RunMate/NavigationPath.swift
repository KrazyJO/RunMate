//
//  NavigationPath.swift
//  RunMate
//
//  Created by Jörn Otte on 15.03.23.
//

import Foundation

enum Routes: Hashable {
    static func == (lhs: Routes, rhs: Routes) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .preparation(let definition):
            combineDefinition(definition: definition, hasher: &hasher)
            return hasher.combine("preparation")
        case .timer(let definition):
            combineDefinition(definition: definition, hasher: &hasher)
            return hasher.combine("timer")
        }
    }
    
    func combineDefinition(definition: TimerDefinition, hasher: inout Hasher) {
        hasher.combine(definition.workout)
        hasher.combine(definition.pause)
        hasher.combine(definition.preparation)
        hasher.combine(definition.rounds)
    }
    
    case timer(definition: TimerDefinition)
    case preparation(definition: TimerDefinition)
}

class NavigationPath: ObservableObject {
    @Published var path: [Routes] = []
    
    func toTimer(definition: TimerDefinition) {
        path.removeAll()
        path.append(.timer(definition: definition))
    }
    
    func toPreparation(definition: TimerDefinition) {
        path.append(.preparation(definition: definition))
    }
}
