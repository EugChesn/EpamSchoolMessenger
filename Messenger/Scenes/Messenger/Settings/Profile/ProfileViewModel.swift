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
}

class ProfileViewModel: ProfileViewModeling {
    weak var view: ProfileDelegate?
    
    private var data = Contact()
    var contact:Contact {
        return data
    }
    
    init(view: ProfileDelegate) {
        self.view = view
        getDataProfile()
    }
    
    private func getDataProfile()  {
        FirebaseService.firebaseService.getUserData() { [weak self] (user) in
            guard let self = self else { return }
            guard let current = user else { return }
            
            self.data = current
            self.view?.updateProfile(user: self.data)
        }
    }
    
    func updateDataProfile(update: [String: String]) {
        FirebaseService.firebaseService.writeNewDataProfile(update: update)
    }
}
