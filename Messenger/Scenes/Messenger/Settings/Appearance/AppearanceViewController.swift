//
//  AppearanceViewController.swift
//  Messenger
//
//  Created by Анастасия Демидова on 26.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol AppearanceDelegate: class {
    
}

class AppearanceViewController: UIViewController {
    var viewModel: AppearanceViewModeling?
    var router: AppearanceRoutering?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    private func setupDependencies() {
        viewModel = AppearanceViewModel(view: self)
        router = AppearanceRouter(viewController: self)
    }
}

extension AppearanceViewController: AppearanceDelegate {
    
}
