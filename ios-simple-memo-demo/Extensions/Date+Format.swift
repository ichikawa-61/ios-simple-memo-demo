//
//  Date+Format.swift
//  ios-simple-memo-demo
//
//  Created by Eiji Kushida on 2017/05/23.
//  Copyright © 2017年 Eiji Kushida. All rights reserved.
//

import Foundation

extension Date {

    /// 対象の日付が今日 or 今年 or 翌年以降によって表示を切り替える
    /// 今日 　　: HH:mm
    /// 今年　　 : MM/dd
    /// 翌年以降 : yyyy/MM/dd
    func dateStyle() -> String {

        let nowDate = Date().now()
        let components = Calendar.current
            .dateComponents([.year, .month, .day, .hour, .minute], from: self)

        if let year = components.year,
            let month = components.month,
            let day = components.day,
            let hour = components.hour,
            let minite = components.minute {

            if !isSameYear(date: nowDate) {
                return String(format: "%04d/%02d/%02d", year, month, day)
            }

            if !isSameDay(date: nowDate) {
                return String(format: "%02d/%02d", month, day)
            }
            return String(format: "%02d:%02d", hour, minite)
        }
        return ""
    }

    /// 同じ年か？
    ///
    /// - Parameter date: 該当の日付
    /// - Returns: 同じ年か
    func isSameYear(date: Date) -> Bool {
        return Calendar.current
            .compare(date, to: self, toGranularity: .year) == .orderedSame
    }

    /// 同じ日か？
    ///
    /// - Parameter date: 該当の日付
    /// - Returns: 同じ日か？
    func isSameDay(date: Date) -> Bool {
        return Calendar.current
            .compare(date, to: self, toGranularity: .day) == .orderedSame
    }
}
