//
//  SignInViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation



class SignInViewModel {
    
    
    func login(number: String, password: String) -> Bool {
        let autorizeModel = AutorizeModel(phone: number, password: password)
        
        return autorizeModel.autorize()
    }
}
