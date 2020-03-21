//
//  RegistrationCodeConfirmationViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol RegistrationCodeConfirmationViewModeling {
    
}

class RegistrationCodeConfirmationViewModel: RegistrationCodeConfirmationViewModeling {
    weak var view: RegistrationCodeConfirmationDelegate?
    
    init(view: RegistrationCodeConfirmationDelegate) {
        self.view = view
    }
}
