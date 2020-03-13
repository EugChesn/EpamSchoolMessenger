//
//  NewPasswordViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol NewPasswordDelegate: class {
    
}

class NewPasswordViewController: UIViewController {
    var viewModel: NewPasswordViewModeling?
    var router: NewPasswordRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    
    func setupDependencies() {
        viewModel = NewPasswordViewModel(view: self)
        router = NewPasswordRouter(viewController: self)
    }
}

extension NewPasswordViewController: NewPasswordDelegate {
    
}
