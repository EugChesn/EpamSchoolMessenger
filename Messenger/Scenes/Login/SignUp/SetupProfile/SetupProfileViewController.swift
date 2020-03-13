//
//  SetupProfileViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol SetupProfileDelegate: class {
    
}

class SetupProfileViewController: UIViewController {
    var viewModel: SetupProfileViewModeling?
    var router: SetupProfileRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    
    func setupDependencies() {
        viewModel = SetupProfileViewModel(view: self)
        router = SetupProfileRouter(viewController: self)
    }
}

extension SetupProfileViewController: SetupProfileDelegate {
    
}
