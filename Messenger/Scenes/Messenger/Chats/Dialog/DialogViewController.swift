//
//  DialogViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 15.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol DialogDelegate: class {
    
}

class DialogViewController: UIViewController {
    var viewModel: DialogViewModeling?
    var router: DialogRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    
    func setupDependencies() {
        viewModel = DialogViewModel(view: self)
        router = DialogRouter(viewController: self)
    }
}

extension DialogViewController: DialogDelegate {
    
}
