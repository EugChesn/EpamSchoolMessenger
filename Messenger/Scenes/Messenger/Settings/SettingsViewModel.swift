//
//  SettingsViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol SettingsViewModeling {
    func editProfile()
}

class SettingsViewModel: SettingsViewModeling {
    weak var view: SettingsDelegate?
    
    init(view: SettingsDelegate) {
        self.view = view
    }
    
    func editProfile() {
        self.view?.openProfile()
    }
}

//Сделать добавление к полям ячейки профиля из userDefault
