//
//  DateManager.swift
//  SportsProject
//
//  Created by Mohammed Adel on 02/10/2023.
//

import Foundation


/*
 print("+++++++++++++++++")
 let str = DateManager.shared.currentDateInStringFormat()
 print(str)
 
 let str2 = DateManager.shared.nextDateInStringFormat(8)
 print(str2)
 
 let str3 = DateManager.shared.previousDaysInStringFormat(-5)
 print(str3)
 print("+++++++++++++++++")

 
 output:
 +++++++++++++++++
 2023-10-02
 2023-10-08
 2023-09-27
 +++++++++++++++++
 */

final class DateManager {
    
    private  let now = Date()
    private  let calendar = Calendar.current
    private  let dateFormatter = DateFormatter()

    static let shared = DateManager()
    
    private init() {}
    
    // MARK: - Next number of days
    func nextDateInStringFormat(_ day: Int = 0) -> String {
        let components = DateComponents(calendar: calendar, day: day)  // next number of days
        let sevenDaysNetx = calendar.nextDate(after: now, matching: components, matchingPolicy: .nextTime)!
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: sevenDaysNetx)
        return stringDate
    }
    
    // MARK: - Last number of days
    func previousDaysInStringFormat(_ day: Int = -1) -> String {
        let dayCopy = day > 0 ? day * -1 : day // to make sure day is negative number
        let sevenDaysBefore = Calendar.current.date(byAdding: .day, value: dayCopy, to: now)!

        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: sevenDaysBefore)
        return stringDate
    }
    
    // MARK: - Current Date
    func currentDateInStringFormat() -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let stringDate = dateFormatter.string(from: now)
        return stringDate
    }
}
