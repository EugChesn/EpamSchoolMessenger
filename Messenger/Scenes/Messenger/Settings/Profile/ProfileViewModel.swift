//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by Анастасия Демидова on 25.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ProfileViewModeling {
}

private var data = Contact()

class ProfileViewModel: ProfileViewModeling {
    
    weak var view: ProfileDelegate?
    
    init(view: ProfileDelegate) {
        self.view = view
        getDataProfile()
    }
    
    private func getDataProfile()  {
        let base = FirebaseService.firebaseService
        base.getUserData() { [weak self] (user) in
            guard let current = user else { return }
            
            data = current
            self?.view?.updateProfile(user: data)
        }
    }
}
