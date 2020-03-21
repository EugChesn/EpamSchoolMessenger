//
//  CreatePasswordViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol CreatePasswordViewModeling {
    
}

class CreatePasswordViewModel: CreatePasswordViewModeling {
    weak var view: CreatePasswordDelegate?
    
    init(view: CreatePasswordDelegate) {
        self.view = view
    }
}
