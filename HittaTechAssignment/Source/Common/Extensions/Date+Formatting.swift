//
//  Date+Formatting.swift
//  HittaTechAssignment
//
//  Created by Raluca Toadere on 08/12/2018.
//  Copyright © 2018 Raluca Toadere. All rights reserved.
//

import Foundation

extension Date {
    static let gregorianCalendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "GMT")!
        return calendar
    }()

    func timestampFormat() -> String {
        let components = Date.gregorianCalendar.dateComponents([.minute, .hour, .day], from: self, to: Date())
        if let days = components.day, days > 0 {
            if days < 5 {
                return "\(days)d ago"
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM d, yyyy"
                return dateFormatter.string(from: self)
            }
        }

        if let hours = components.hour, hours > 0 {
            return "\(hours)h ago"
        }

        if let minutes = components.minute, minutes > 0 {
            return "\(minutes)m ago"
        } else {
            return "1m ago"
        }
    }
}
