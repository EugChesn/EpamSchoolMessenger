//
//  UserSettings.swift
//  Messenger
//
//  Created by Анастасия Демидова on 12.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

class UserSettings {
    static func save(object: String, for key: String) {
        if UserDefaults.standard.value(forKey: key) != nil {
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.set(object, forKey: key)
    }
    
    static func getObject(for key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
}
