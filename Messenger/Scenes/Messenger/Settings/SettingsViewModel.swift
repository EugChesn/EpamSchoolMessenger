//
//  SettingsViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol SettingsViewModeling {
    func getDataProfile()
    var contact: Contact { get }
    
    func openInfo()
    func editProfile()
    func languageSetting()
    func appearanceSetting()
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
    
    func appearanceSetting() {
        self.view?.openAppearance()
    }
    
    func openInfo() {
        self.view?.openInfo()
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
