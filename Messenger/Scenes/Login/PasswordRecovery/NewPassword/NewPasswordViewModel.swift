//
//  NewPasswordViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol NewPasswordViewModeling {
    
}

class NewPasswordViewModel: NewPasswordViewModeling {
    weak var view: NewPasswordDelegate?
    
    init(view: NewPasswordDelegate) {
        self.view = view
    }
}
