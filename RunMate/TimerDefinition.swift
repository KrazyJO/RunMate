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
    let round: Int
}

class TimerDefinition: ObservableObject {

    var stack = [Step]()
    @Published var stepCounter = 0
    var rounds: Int
    let preparation: Int
    let workout: Int
    let pause: Int

    var currentStep: Step? {
        if stepCounter >= stack.count {
            return nil
        }
        return stack[stepCounter]
    }

    init(preparation: Int, workout: Int, pause: Int, rounds: Int) {
        self.rounds = rounds
        self.preparation = preparation
        self.pause = pause
        self.workout = workout
        
        buildStack()
    }
    
    func buildStack() {
        for round in 1...rounds {
            stack.append(Step(type: .workout, time: workout, round: round))
            stack.append(Step(type: .pause, time: pause, round: round))
        }
        stack.removeLast()
    }

    func nextStep() {
        if stepCounter < stack.count {
            stepCounter += 1
        }
    }

    func previousStep() {
        if stepCounter > 0 {
            stepCounter -= 1
        }

    }

}
