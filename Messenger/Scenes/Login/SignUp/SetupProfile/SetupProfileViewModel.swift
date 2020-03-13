//
//  SetupProfileViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol SetupProfileViewModeling {
    
}

class SetupProfileViewModel: SetupProfileViewModeling {
    weak var view: SetupProfileDelegate?
    
    init(view: SetupProfileDelegate) {
        self.view = view
    }
}
