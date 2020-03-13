//
//  CodeConfirmationViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol CodeConfirmationDelegate: class {
    
}

class CodeConfirmationViewController: UIViewController {
    var viewModel: CodeConfirmationViewModeling?
    var router: CodeConfirmationRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    
    func setupDependencies() {
        viewModel = CodeConfirmationViewModel(view: self)
        router = CodeConfirmationRouter(viewController: self)
    }
}

extension CodeConfirmationViewController: CodeConfirmationDelegate {
    
}
