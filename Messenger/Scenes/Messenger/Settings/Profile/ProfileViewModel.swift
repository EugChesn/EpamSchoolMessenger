//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by Анастасия Демидова on 25.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ProfileViewModeling {
    func getContact() -> Contact
}

private var userData = Contact()

class ProfileViewModel: ProfileViewModeling {
    
    func getContact() -> Contact {
        return userData
    }
    
    weak var view: ProfileDelegate?
    
    init(view: ProfileDelegate) {
        self.view = view
        getDataProfile()
    }
    
    private func getDataProfile()  {
        let base = FirebaseService.firebaseService
        base.getUserData() { (user) in
            guard let current = user else { return }
            
            userData = current
        }
    }
}
