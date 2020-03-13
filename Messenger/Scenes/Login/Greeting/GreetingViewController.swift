//
//  GreetingViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol GreetingDelegate: class {
    
}

class GreetingViewController: UIViewController {
    var viewModel: GreetingViewModeling?
    var router: GreetingRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    
    func setupDependencies() {
        viewModel = GreetingViewModel(view: self)
        router = GreetingRouter(viewController: self)
    }
}

extension GreetingViewController: GreetingDelegate {
    
}
