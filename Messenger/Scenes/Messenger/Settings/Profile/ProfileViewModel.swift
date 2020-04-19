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
    var contact: Contact { get }
    var userName: String { get }
    var userNickname: String { get }
    func updateUserDefaults(_ name: String, _ nickname: String)
}

class ProfileViewModel: ProfileViewModeling {
    weak var view: ProfileDelegate?
    weak var base = FirebaseService.firebaseService
    
    private var data = Contact()
    var contact: Contact {
        return data
    }
    
    var userName: String {
        return UserSettings.getObject(for: ProfileSetting.name) as! String
    }
    
    var userNickname: String {
        return UserSettings.getObject(for: ProfileSetting.nickname) as! String
    }
    
    init(view: ProfileDelegate) {
        self.view = view
        getDataProfile()
        updateUserDefaults(data.name ?? "", data.nickname ?? "")
    }
    
    private func getDataProfile()  {
        base?.getUserData() { [weak self] (user) in
            guard let self = self else { return }
            guard let current = user else { return }
            
            self.data = current
            self.view?.updateProfile(user: self.data)
        }
    }
    
    func updateDataProfile(update: [String: String]) {
        //base?.writeNewDataProfile(update: update)
        base?.writeNewDataCurrUser(update: update) { errorWrite in
            if let errorWrite = errorWrite {
                print("error write profile data(settings)")
            }
        }
    }
    
    func updateUserDefaults(_ name: String, _ nickname: String) {
        UserSettings.save(object: name, for: ProfileSetting.name)
        UserSettings.save(object: nickname, for: ProfileSetting.nickname)
    }
}
