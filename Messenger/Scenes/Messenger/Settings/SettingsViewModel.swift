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
    func contact() -> Contact
}

class SettingsViewModel: SettingsViewModeling {
    weak var view: SettingsDelegate?
    
    private var data = Contact()
    
    init(view: SettingsDelegate) {
        self.view = view
        getDataProfileSettings()
    }
    
    func contact() -> Contact {
        return data
    }
    
    func editProfile() {
        self.view?.openProfile()
    }
    
    private func getDataProfileSettings() {
        FirebaseService.firebaseService.getUserData() { [weak self] (user) in
            guard let current = user else { return }
            self?.data = current
            self?.view?.updateProfile(user: current)
        }
    }
}
