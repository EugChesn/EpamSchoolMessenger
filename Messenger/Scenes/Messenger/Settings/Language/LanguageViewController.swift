//
//  LanguageViewController.swift
//  Messenger
//
//  Created by Анастасия Демидова on 20.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol LanguageDelegete: class {
    
}

class LanguageViewController: UIViewController {
    var viewModel: LanguageViewModeling?
    var router: LanguageRoutering?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    private func setupDependencies() {
        viewModel = LanguageViewModel(view: self)
        router = LanguageRouter(viewController: self)
    }
}

extension LanguageViewController: LanguageDelegete {
    
}
