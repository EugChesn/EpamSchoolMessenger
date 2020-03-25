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

class ProfileViewModel: ProfileViewModeling {
    weak var view: ProfileDelegate?
    
    init(view: ProfileDelegate) {
        self.view = view
    }
}
