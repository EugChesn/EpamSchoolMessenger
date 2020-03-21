//
//  PasswordRecoveryViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol PasswordRecoveryViewModeling {
    
}

class PasswordRecoveryViewModel: PasswordRecoveryViewModeling {
    weak var view: PasswordRecoveryDelegate?
    
    init(view: PasswordRecoveryDelegate) {
        self.view = view
    }
}
