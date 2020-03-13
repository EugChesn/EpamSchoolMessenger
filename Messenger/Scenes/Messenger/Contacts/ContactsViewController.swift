//
//  ContactsViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol ContactsDelegate: class {
    
}

class ContactsViewController: UIViewController {
    var viewModel: ContactsViewModeling?
    var router: ContactsRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    
    func setupDependencies() {
        viewModel = ContactsViewModel(view: self)
        router = ContactsRouter(viewController: self)
    }
}

extension ContactsViewController: ContactsDelegate {
    
}
