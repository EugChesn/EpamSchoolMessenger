//
//  NetworkService.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

struct FireBaseRequst {
    var number: String
    var password: String
}

class NetworkService {
    func authorizeUser(number: String, password: String) -> Bool{
        //Некоторый код, который авторизует по данным на сервере
        return true
    }
}
