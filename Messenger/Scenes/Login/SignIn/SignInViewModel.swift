//
//  SignInViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol SignInViewModeling {
    
}

class SignInViewModel: SignInViewModeling {
    weak var view: SignInDelegate?
    
    init(view: SignInDelegate) {
        self.view = view
    }
}
