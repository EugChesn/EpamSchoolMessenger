//
//  AutorizeModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

class AutorizeModel {
    private let network = NetworkService()
    private let storage = StorageService()
    
    private var phone: String
    private var password: String
    
    init(phone: String, password: String) {
        self.phone = phone
        self.password = password
    }
    
    func autorize() -> Bool{
        let isAutorize = network.authorizeUser(number: phone,
                                               password: password)
        if(isAutorize) {
            storage.saveUserForAutorization(number: phone,
                                            password: password)
        }
        
        return isAutorize
    }
    
}
