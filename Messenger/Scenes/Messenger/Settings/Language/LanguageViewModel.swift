//
//  LanguageViewModel.swift
//  Messenger
//
//  Created by Анастасия Демидова on 20.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol LanguageViewModeling {
    var lenguage: String? { get }
}

class LanguageViewModel: LanguageViewModeling {
    weak var view: LanguageDelegete?
    
    var lenguage: String?
    
    init(view: LanguageDelegete) {
        self.view = view
        defineLanguage()
    }
    
    private func defineLanguage() {
        lenguage = Locale.current.languageCode ?? ""
    }
}
