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
    var contact: Contact { get }
    func languageSetting()
}

class SettingsViewModel: SettingsViewModeling {
    weak var view: SettingsDelegate?
    
    private var data = Contact()
    var contact: Contact {
        return data
    }
    
    init(view: SettingsDelegate) {
        self.view = view
        getDataProfileSettings()
    }
    
    func editProfile() {
        self.view?.openProfile()
    }
    
    func languageSetting() {
        self.view?.openLanguage()
    }
    
    private func getDataProfileSettings() {
        FirebaseService.firebaseService.getUserData() { [weak self] (user) in
            guard let self = self else { return }
            guard let current = user else { return }
            
            self.data = current
            self.view?.updateProfile(user: current)
        }
    }
}
