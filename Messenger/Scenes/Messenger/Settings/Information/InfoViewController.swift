//
//  InfoViewController.swift
//  Messenger
//
//  Created by Анастасия Демидова on 27.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol InfoDelegate: class {
    
}

class InfoViewController: UIViewController{
    var viewModel: InfoViewModeling?
    var router: InfoRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    func setupDependencies() {
        viewModel = InfoViewModel(view: self)
        router = InfoRouter(viewController: self)
    }
    
}

extension InfoViewController: InfoDelegate {
    
}


