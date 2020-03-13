//
//  Reachability.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol Reachability {
    func checkInternetAvailability() -> Bool
}

class NetworkReachability: Reachability {
    func checkInternetAvailability() -> Bool {
        return true
    }
}
