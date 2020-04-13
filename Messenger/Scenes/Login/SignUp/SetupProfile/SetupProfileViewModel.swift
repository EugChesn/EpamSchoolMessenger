//
//  SetupProfileViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol SetupProfileViewModeling {
    func setupProfileUser(name: String, nickname: String, photo: UIImage)
}

class SetupProfileViewModel: SetupProfileViewModeling {
    weak var view: SetupProfileDelegate?
    
    init(view: SetupProfileDelegate) {
        self.view = view
    }
    
    func setupProfileUser(name: String, nickname: String, photo: UIImage) {
        FirebaseService.firebaseService.setProfileUser(name: name, nickName: nickname, photo: photo) {
            self.view?.profileSucces()
            
            UserSettings.save(object: name, for: ProfileSetting.name)
            UserSettings.save(object: nickname, for: ProfileSetting.nickname)
        }
    }
}
