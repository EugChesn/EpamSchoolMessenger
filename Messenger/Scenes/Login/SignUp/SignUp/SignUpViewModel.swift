//
//  SignUpViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol SignUpViewModeling {
    func registerUser(email: String, password: String)
}

class SignUpViewModel: SignUpViewModeling {
    weak var view: SignUpDelegate?
    
    init(view: SignUpDelegate) {
        self.view = view
    }
    
    func registerUser(email: String, password: String) {
        FirebaseService.firebaseService.createUser(username: email, password: password) { (err) in
            if let error = err {
                print("error create User")
            } else {
                self.view?.successCreateUser()
            }
        }
    }
}

