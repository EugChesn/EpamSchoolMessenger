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
    //func openProfile()
}

class SettingsViewController: UITableViewController {
    @IBOutlet private weak var profileCell: UITableViewCell!
    @IBOutlet private weak var profileImage: UIImageView!
    
    var viewModel: SettingsViewModeling?
    var router: SettingsRouting?
    let searchController = UISearchController(searchResultsController: nil)
    
    private enum Constant {
        static let setting = "Settings"
        static let rightBarButtonItem = "Edit"
        static let search = "Search"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem?.title = Constant.rightBarButtonItem
//MARK: SearchBar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = Constant.search
        navigationItem.searchController = searchController
        definesPresentationContext = true
//MARK: Cell setting
        profileCell.accessoryType = .disclosureIndicator
//MARK: Image setting
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = 40
        
        setupDependencies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = Constant.setting
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
//    func openProfile() {
//        router?.routeToTable(withIdentifier: "ProfileViewController", sender: self)
//    }
}
