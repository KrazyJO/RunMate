//
//  TimerDefinition.swift
//  RunMate
//
//  Created by Jörn Otte on 04.03.23.
//

import Foundation

enum RoundType {
    case pause
    case workout
    case preparation
}

struct Step {
    let type: RoundType
    let time: Int
}

class TimerDefinition {
    
    var stack = [Step]()
    private var stepCounter = 0
    
    var currentStep: Step? {
        return stack[stepCounter]
    }
    
    init(preparation: Int, workout: Int, pause: Int, rounds: Int) {
        stack.append(Step(type: .preparation, time: preparation))
        for _ in 1...rounds {
            stack.append(Step(type: .workout, time: workout))
            stack.append(Step(type: .pause, time: pause))
        }
        stack.removeLast()
    }
    
    func nextStep() {
        stepCounter = stepCounter + 1
    }
    
}
