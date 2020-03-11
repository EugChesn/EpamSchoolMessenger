//
//  SignInViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation



class SignInViewModel {
    private let network = NetworkService()
    private let storage = StorageService()
    
    func login(number: String, password: String) -> Bool {
        let isAutorize = network.authorizeUser(number: number,
                                               password: password)
        if(isAutorize) {
            storage.saveUserForAutorization(number: number,
                                            password: password)
        }
        
        return isAutorize
    }
}
