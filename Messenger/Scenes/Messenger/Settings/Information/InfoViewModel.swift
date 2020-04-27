//
//  InfoViewModel.swift
//  Messenger
//
//  Created by Анастасия Демидова on 27.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol InfoViewModeling {
    
}

class InfoViewModel: InfoViewModeling {
    weak var view: InfoDelegate?
    
    init(view: InfoDelegate) {
        self.view = view
    }
}
