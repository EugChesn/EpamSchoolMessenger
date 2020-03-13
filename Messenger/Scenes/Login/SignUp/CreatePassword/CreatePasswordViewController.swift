//
//  CreatePasswordViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol CreatePasswordDelegate: class {
    
}

class CreatePasswordViewController: UIViewController {
    var viewModel: CreatePasswordViewModeling?
    var router: CreatePasswordRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    
    func setupDependencies() {
        viewModel = CreatePasswordViewModel(view: self)
        router = CreatePasswordRouter(viewController: self)
    }
}

extension CreatePasswordViewController: CreatePasswordDelegate {
    
}
