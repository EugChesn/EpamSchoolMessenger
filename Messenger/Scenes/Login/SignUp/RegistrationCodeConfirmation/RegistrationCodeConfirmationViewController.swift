//
//  RegistrationCodeConfirmationViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol RegistrationCodeConfirmationDelegate: class {
    
}

class RegistrationCodeConfirmationViewController: UIViewController {
    var viewModel: RegistrationCodeConfirmationViewModeling?
    var router: RegistrationCodeConfirmationRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    
    func setupDependencies() {
        viewModel = RegistrationCodeConfirmationViewModel(view: self)
        router = RegistrationCodeConfirmationRouter(viewController: self)
    }
}

extension RegistrationCodeConfirmationViewController: RegistrationCodeConfirmationDelegate {
    
}
