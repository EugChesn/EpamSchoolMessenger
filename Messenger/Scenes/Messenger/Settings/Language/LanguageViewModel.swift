//
//  LanguageViewModel.swift
//  Messenger
//
//  Created by Анастасия Демидова on 20.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol LanguageViewModeling {
    
}

class LanguageViewModel: LanguageViewModeling {
    weak var view: LanguageDelegete?
    
    init(view: LanguageDelegete) {
        self.view = view
    }
}
