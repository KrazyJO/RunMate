//
//  DateFormatterTest.swift
//  RunMateTests
//
//  Created by Jörn Otte on 11.03.23.
//

import XCTest
@testable import RunMate

class DateFormatterTest: XCTestCase {

    func testSecToTime() {
        var seconds = 10
        var formatted = DateFormatter.secToTime(seconds: seconds)

        XCTAssertEqual(formatted, "00:10")

        seconds = 72
        formatted = DateFormatter.secToTime(seconds: seconds)

        XCTAssertEqual(formatted, "01:12")

        // 1 Hour, 35 Min, 12 Sec
        seconds = (1*60*60)+(35*60)+(12)
        formatted = DateFormatter.secToTime(seconds: seconds)

        XCTAssertEqual(formatted, "01:35:12")

    }
}
