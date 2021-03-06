//
//  NetworkService.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol NetworkInteraction {
    
}

class NetworkService: NetworkInteraction {
    static var shared: NetworkInteraction = {
        let instance = NetworkService()
        return instance
    }()
    
    private init() {}
}
