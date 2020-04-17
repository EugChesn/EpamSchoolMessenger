//
//  DateExtensions.swift
//  Messenger
//
//  Created by Евгений Гусев on 05.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

extension Date {
    var currentTime: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MMM/dd HH:mm:ss"
            let time = dateFormatter.string(from: self)
            return time
        }
    }
    
    static func timeMessageToString(_ value: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MMM/dd HH:mm:ss"
        if let newDate = dateFormatter.date(from: value) {
            return newDate
        }
        else { return nil }
    }
    
    func formatingDate(style: DateFormatter.Style, format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = style
        formatter.dateFormat = format
        let dateResult = formatter.string(from: self)
        return dateResult
    }
    
    enum DaysWeek: Int {
        case Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
    }
    
    func getTimeMessage() -> String?{
        let myCalendar = Calendar(identifier: .gregorian)
        let componentsDate = myCalendar.dateComponents([.year, .month, .day], from: self)
        let weekDay = myCalendar.dateComponents([.weekday], from: self).weekday
        
        let currentDate = Date()
        let currentComponentsDate = myCalendar.dateComponents([.year, .month, .day], from: currentDate)
        
        var resultDateStr: String!
        if currentComponentsDate.year == componentsDate.year &&
            currentComponentsDate.month == componentsDate.month {
            
            if let curDay = currentComponentsDate.day, let day = componentsDate.day {
                if curDay == day  {
                    return self.formatingDate(style: .short, format: "HH:mm")
                } else if abs(curDay - day) > 7 {
                    return self.formatingDate(style: .short, format: "dd:MM")
                } else {
                    if let weekDay = weekDay {
                        switch weekDay {
                        case DaysWeek.Monday.rawValue:
                            resultDateStr = "Monday"
                        case DaysWeek.Thursday.rawValue:
                            resultDateStr =  "Thursday"
                        case DaysWeek.Wednesday.rawValue:
                            resultDateStr =  "Wednesday"
                        case DaysWeek.Tuesday.rawValue:
                            resultDateStr =  "Tuesday"
                        case DaysWeek.Friday.rawValue:
                            resultDateStr =  "Friday"
                        case DaysWeek.Saturday.rawValue:
                            resultDateStr =  "Saturday"
                        case DaysWeek.Sunday.rawValue:
                            resultDateStr =  "Sunday"
                        default:
                            print("error range day")
                        }
                    }
                }
            }
        }
        return resultDateStr
    }
}
