//
//  StorageService.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol StorageData {
    
}

class StorageService: StorageData {
    static var shared: StorageData = {
        let instance = StorageService()
        return instance
    }()
    
    private init() {}
}
