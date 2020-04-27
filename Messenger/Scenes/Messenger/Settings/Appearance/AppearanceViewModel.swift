//
//  AppearanceViewModel.swift
//  Messenger
//
//  Created by Анастасия Демидова on 26.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol AppearanceViewModeling {
    func saveSetting(image: String)
}

class AppearanceViewModel: AppearanceViewModeling {
    weak var view: AppearanceDelegate?
    
    init(view: AppearanceDelegate) {
        self.view = view
    }
    
    func saveSetting(image: String) {
        UserSettings.save(object: image, for: AppearanceKey.imageBackgroundChat)
    }
}
