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
    func languageSetting()
    var contact: Contact { get }
    func getDataProfile()
}

class SettingsViewModel: SettingsViewModeling {
    weak var view: SettingsDelegate?
    
    private var data = Contact()
    var contact: Contact {
        return data
    }
    
    init(view: SettingsDelegate) {
        self.view = view
    }
    
    func editProfile() {
        self.view?.openProfile()
    }
    
    func languageSetting() {
        self.view?.openLanguage()
    }
    
    func getDataProfile() {
        FirebaseService.firebaseService.getUserData() { [weak self] (user) in
            guard let self = self else { return }
            guard let current = user else { return }
            
            self.data = current
            self.view?.updateProfile(user: current)
        }
    }
}
