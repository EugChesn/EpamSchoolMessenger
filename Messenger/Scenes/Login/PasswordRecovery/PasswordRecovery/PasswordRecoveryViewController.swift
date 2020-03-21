//
//  PasswordRecoveryViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol PasswordRecoveryDelegate: class {
    
}

class PasswordRecoveryViewController: UIViewController {
    var viewModel: PasswordRecoveryViewModeling?
    var router: PasswordRecoveryRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    
    func setupDependencies() {
        viewModel = PasswordRecoveryViewModel(view: self)
        router = PasswordRecoveryRouter(viewController: self)
    }
}

extension PasswordRecoveryViewController: PasswordRecoveryDelegate {
    
}
