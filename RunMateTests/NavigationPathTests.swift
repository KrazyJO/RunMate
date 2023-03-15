//
//  NavigationPathTests.swift
//  RunMateTests
//
//  Created by Jörn Otte on 15.03.23.
//

import XCTest
@testable import RunMate

class NavigationPathTests: XCTestCase {
    
    func testToPreparations() {
        let path = NavigationPath()
        path.path.append(.timer(definition: newDefinition(1)))
        path.path.append(.timer(definition: newDefinition(2)))
        
        // test
        path.toPreparation(definition: newDefinition(3))
        XCTAssertEqual(path.path.count, 3)
    }
    
    func testToTimer() {
        // prepare
        let path = NavigationPath()
        path.path.append(.preparation(definition: newDefinition(1)))
        path.path.append(.preparation(definition: newDefinition(2)))
        
        // test
        path.toTimer(definition: newDefinition(3))
        XCTAssertEqual(path.path.count, 1)
    }
    
    func testRoutesEquals() {
        let objA = Routes.timer(definition: newDefinition(1))
        let objB = Routes.timer(definition: newDefinition(2))
        let objC = Routes.timer(definition: newDefinition(1))
        
        XCTAssertNotEqual(objA, objB)
        XCTAssertEqual(objA, objC)
    }
    
}

extension NavigationPathTests {
    
    func newDefinition(_ num: Int) -> TimerDefinition {
        return TimerDefinition(preparation: num, workout: num, pause: num, rounds: num)
    }
    
}
