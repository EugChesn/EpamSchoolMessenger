//
//  AutorizeModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

struct UserToken {
    var phone: String
    var token: String
    
    init(phone: String, token: String) {
        self.phone = phone
        self.token = token
    }
}

class AutorizeModel {
    private let network = NetworkService()
    private let storage = StorageService()
    
    private var phone: String
    private var password: String
    
    private var token: String?
    
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
        token = "someToken"
        
        return isAutorize
    }
    
    func getUserToken() -> UserToken? {
        if let token = token {
            let userToken = UserToken(phone: phone, token: token)
            return userToken
        } else {
            return nil
        }
    }
    
}
