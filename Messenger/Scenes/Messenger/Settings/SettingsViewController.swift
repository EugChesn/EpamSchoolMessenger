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
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLable: UILabel!
    
    var viewModel: SettingsViewModeling?
    var router: SettingsRouting?
    let searchController = UISearchController(searchResultsController: nil)
    
    private enum Constant {
        static let rightBarButtonItem = "Edit"
        static let setting = "Settings"
        static let search = "Search"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationItem()
//MARK: SearchBar
        Decor.searchBar(searchController, placeholder: Constant.search)
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
//MARK: Cell setting
        Decor.styleCell(profileCell)
//MARK: Image setting
        Decor.styleImageView(profileImage)
        
        setupDependencies()
    }
    
    func setupDependencies() {
        viewModel = SettingsViewModel(view: self)
        router = SettingsRouter(viewController: self)
    }
    
    func settingNavigationItem() {
        navigationItem.rightBarButtonItem?.title = Constant.rightBarButtonItem
        navigationItem.title = Constant.setting
        navigationItem.searchController = searchController
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
