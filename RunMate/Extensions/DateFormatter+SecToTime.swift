//
//  DateFormatter+SecToTime.swift
//  RunMate
//
//  Created by Jörn Otte on 11.03.23.
//

import Foundation

extension DateFormatter {
    static func secToTime(seconds: Int) -> String {
        let interval = TimeInterval(seconds)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        if seconds < 60*60 {
            formatter.dateFormat = "mm:ss"
        } else {
            formatter.dateFormat = "hh:mm:ss"
        }

        let formatted = formatter.string(from: Date(timeIntervalSinceReferenceDate: interval))
        return formatted
    }
}
