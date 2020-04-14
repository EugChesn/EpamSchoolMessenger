//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by Анастасия Демидова on 25.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ProfileViewModeling {
    func updateDataProfile(update: [String: String])
    func contact() -> Contact
}

class ProfileViewModel: ProfileViewModeling {
    weak var view: ProfileDelegate?
    
    private var data = Contact()
    
    func contact() -> Contact {
        return data
    }
    
    let base = FirebaseService.firebaseService
    
    init(view: ProfileDelegate) {
        self.view = view
        getDataProfile()
    }
    
    private func getDataProfile()  {
        base.getUserData() { [weak self] (user) in
            guard let self = self else { return }
            guard let current = user else { return }
            
            self.data = current
            self.view?.updateProfile(user: self.data)
            
            let profile = ProfileSetting(current.name, current.nickname, current.email)
            UserSettings.save(object: profile.name, for: ProfileSetting.name)
            UserSettings.save(object: profile.nickname, for: ProfileSetting.nickname)
        }
    }
    
    func updateDataProfile(update: [String: String]) {
        base.writeNewDataProfile(update: update)
    }
}
