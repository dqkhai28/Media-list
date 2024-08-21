//
//  DateExtension.swift
//  MediaList
//
//  Created by KaiD on 07/02/2023.
//

import Foundation

extension Date {
    /// Get date time of current time zone
    func getCurrentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Constant.dateTimeFormat
        formatter.timeZone = TimeZone.current
        
        return formatter.string(from: self)
    }
}
