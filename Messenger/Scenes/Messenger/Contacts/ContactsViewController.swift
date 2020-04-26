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
    
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var contactTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupDependencies()
    }
    
    func setupDependencies() {
        viewModel = ContactsViewModel(view: self)
        router = ContactsRouter(viewController: self)
    }
    
    func setupUI() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.setTextColor(color: .white)
        
        let textField = searchController.searchBar.value(forKey: "searchField") as! UITextField
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        if #available(iOS 13.0, *) {
            glassIconView.tintColor = .gray
        }
        
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
        navigationItem.title = "Contacts"
    }
}

extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension ContactsViewController: ContactsDelegate {
    
}
