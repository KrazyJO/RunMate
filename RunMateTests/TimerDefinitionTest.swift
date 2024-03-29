//
//  TimerDefinitionTest.swift
//  RunMateTests
//
//  Created by Jörn Otte on 04.03.23.
//

import XCTest
@testable import RunMate

class TimerDefinitionTest: XCTestCase {

    func testInitialization() {
        let definition = TimerDefinition(preparation: 10, workout: 30, pause: 10, rounds: 2)
        XCTAssertEqual(definition.stack.count, 3)

        var stackEntry = definition.stack[0]
        XCTAssertEqual(stackEntry.type, .workout)
        XCTAssertEqual(stackEntry.time, 30)

        stackEntry = definition.stack[1]
        XCTAssertEqual(stackEntry.type, .pause)
        XCTAssertEqual(stackEntry.time, 10)

        stackEntry = definition.stack[2]
        XCTAssertEqual(stackEntry.type, .workout)
        XCTAssertEqual(stackEntry.time, 30)
    }

    func testNextStep() {
        let definition = TimerDefinition(preparation: 10, workout: 30, pause: 10, rounds: 2)
        definition.nextStep()
        XCTAssertEqual(definition.stack.count, 3)
    }

    func testNextStepOnLastStep() {
        let definition = TimerDefinition(preparation: 10, workout: 30, pause: 10, rounds: 2)
        definition.nextStep()
        definition.nextStep()
        definition.nextStep()
        definition.nextStep()
        definition.nextStep()
        definition.nextStep()
        XCTAssertEqual(definition.stepCounter, 3)
    }

    func testPreviousStep() {
        let definition = TimerDefinition(preparation: 10, workout: 30, pause: 10, rounds: 2)
        definition.nextStep()
        definition.nextStep()
        definition.previousStep()
        XCTAssertEqual(definition.stepCounter, 1)
    }

    func testPreviousStepOnFirstStep() {
        let definition = TimerDefinition(preparation: 10, workout: 30, pause: 10, rounds: 2)
        definition.previousStep()
        XCTAssertEqual(definition.stepCounter, 0)
    }

    func testCurrentStep() {
        let definition = TimerDefinition(preparation: 10, workout: 30, pause: 10, rounds: 2)
        var currentStep = definition.currentStep
        XCTAssertEqual(currentStep?.type, .workout)

        definition.nextStep()
        currentStep = definition.currentStep
        XCTAssertEqual(currentStep?.type, .pause)
    }
}
