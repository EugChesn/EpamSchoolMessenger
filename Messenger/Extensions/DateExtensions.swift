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
}
