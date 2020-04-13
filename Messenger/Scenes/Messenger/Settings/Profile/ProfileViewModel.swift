//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by Анастасия Демидова on 25.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ProfileViewModeling {
    func updateDataProfile(name: String, nickname: String, photo: URL?)
}

class ProfileViewModel: ProfileViewModeling {
    weak var view: ProfileDelegate?
    
    private var data = Contact()
    let base = FirebaseService.firebaseService
    
    init(view: ProfileDelegate) {
        self.view = view
        getDataProfile()
    }
    
    private func getDataProfile()  {
        base.getUserData() { [weak self] (user) in
            guard let current = user else { return }
            
            self?.data = current
            self?.view?.updateProfile(user: self!.data)
            
            let profile = ProfileSetting(current.name, current.nickname, current.email)
            UserSettings.save(object: profile.name, for: ProfileSetting.name)
            UserSettings.save(object: profile.nickname, for: ProfileSetting.nickname)
            UserSettings.save(object: profile.email, for: ProfileSetting.email)
        }
    }
    
    func updateDataProfile(name: String, nickname: String, photo: URL?) {
        base.updateProfileInfo(name: name, nickName: nickname, photo: photo)
    }
}
