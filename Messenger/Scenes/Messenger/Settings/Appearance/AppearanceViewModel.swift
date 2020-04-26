//
//  AppearanceViewModel.swift
//  Messenger
//
//  Created by Анастасия Демидова on 26.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol AppearanceViewModeling {

}

class AppearanceViewModel: AppearanceViewModeling {
    weak var view: AppearanceDelegate?
    
    init(view: AppearanceDelegate) {
        self.view = view
    }
}
