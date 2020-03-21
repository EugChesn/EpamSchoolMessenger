//
//  SetupProfileViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol SetupProfileViewModeling {
    func setupProfileUser(name: String, nickname: String)
}

class SetupProfileViewModel: SetupProfileViewModeling {
    weak var view: SetupProfileDelegate?
    
    init(view: SetupProfileDelegate) {
        self.view = view
    }
    
    func setupProfileUser(name: String, nickname: String) {
        FirebaseService.firebaseService.setNameUser(name: name, nickName: nickname) {
            self.view?.profileSucces()
        }
    }
}
