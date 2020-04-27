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
    
    func formatingDate(localIdentifier: String, style: DateFormatter.Style, format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: localIdentifier)
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
        if (currentComponentsDate.year == componentsDate.year &&
            currentComponentsDate.month == componentsDate.month) {
            
            if let curDay = currentComponentsDate.day, let day = componentsDate.day {
                
                if curDay == day  {
                    return self.formatingDate(localIdentifier: "ru_RU", style: .short, format: "HH:mm")
                } else if abs(curDay - day) > 7 {
                    return self.formatingDate(localIdentifier: "ru_RU", style: .short, format: "dd:MM")
                } else {
                    if let weekDay = weekDay {
                        switch weekDay {
                        case DaysWeek.Sunday.rawValue:
                            resultDateStr =  "Su"
                        case DaysWeek.Monday.rawValue:
                            resultDateStr = "Mo"
                        case DaysWeek.Tuesday.rawValue:
                            resultDateStr =  "Tu"
                        case DaysWeek.Wednesday.rawValue:
                            resultDateStr =  "We"
                        case DaysWeek.Thursday.rawValue:
                            resultDateStr =  "Th"
                        case DaysWeek.Friday.rawValue:
                            resultDateStr =  "Fr"
                        case DaysWeek.Saturday.rawValue:
                            resultDateStr =  "Sa"
                        default:
                            print("error range day")
                        }
                    }
                }
                
            }
        } else if (currentComponentsDate.year != componentsDate.year) {
            return self.formatingDate(localIdentifier: "ru_RU", style: .long, format: "yyyy/dd/MMM")
        }
        return resultDateStr
    }
    
    func days(to secondDate: Date, calendar: Calendar = Calendar.current) -> Int? {
        return calendar.dateComponents([.day], from: self, to: secondDate).day
    }
    func mins(to secondDate: Date, calendar: Calendar = Calendar.current) -> Int? {
        return calendar.dateComponents([.minute], from: self, to: secondDate).minute
    }
    func seconds(to secondDate: Date, calendar: Calendar = Calendar.current) -> Int? {
        return calendar.dateComponents([.second], from: self, to: secondDate).second
    }
    
    static func getStatusBaseOnTime(newTime: String) -> String? {
        if let date = Date.timeMessageToString(newTime) {
            if let mins = date.mins(to: Date()), mins > 1 {
                return StatusUser.Offline.rawValue
            } else {
                return StatusUser.Online.rawValue
            }
        } else {
            return nil
        }
    }
    
}
