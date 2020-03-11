//
//  SignInViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation



class SignInViewModel {
    
    var autorizeModel: AutorizeModel?
    
    func login(number: String, password: String) -> Bool {
        autorizeModel = AutorizeModel(phone: number, password: password)
        
        guard let model = autorizeModel else { return false }
        return model.autorize()
    }
    
    func getToken() -> UserToken {
        guard let token = autorizeModel?.getUserToken()
            else { return UserToken(phone: "",token: "") }
        return token
    }
}
