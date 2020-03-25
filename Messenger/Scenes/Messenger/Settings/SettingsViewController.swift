//
//  SettingsViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsDelegate: class {
    func openProfile()
}

class SettingsViewController: UITableViewController {
    @IBOutlet private weak var profileCell: UITableViewCell!

    var viewModel: SettingsViewModeling?
    var router: SettingsRouting?
    
    private enum Title {
        static let setting = "Settings"
        static let rightBarButtonItem = "Edit"
        static let search = "Search"
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem?.title = Title.rightBarButtonItem

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Title.search
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        profileCell.accessoryType = .disclosureIndicator
        
        setupDependencies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = Title.setting
    }
    
    func setupDependencies() {
        viewModel = SettingsViewModel(view: self)
        router = SettingsRouter(viewController: self)
    }
}
 
extension SettingsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension SettingsViewController: SettingsDelegate {
    func openProfile() {
        router?.routeToTable(withIdentifier: "ProfileViewController", sender: self)
    }
}
