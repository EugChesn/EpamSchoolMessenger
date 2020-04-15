//
//  SignUpViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpViewModeling {
    func registerUser(name: String, nick: String,email: String, password: String, image: UIImage?)
}

class SignUpViewModel: SignUpViewModeling {
    weak var view: SignUpDelegate?
    weak var authFirebase: AuthFirebase?
    
    init(view: SignUpDelegate) {
        self.view = view
        authFirebase = FirebaseService.firebaseService
    }
    
    func registerUser(name: String, nick: String,email: String, password: String, image: UIImage?) {
        authFirebase?.registerUser(name: name, nickName: nick, email: email, password: password, photo: image) { error in
            if let err = error {
                self.view?.faultCreateUser(err: err)
            } else {
                self.view?.successCreateUser()
            }
        }
    }
}

