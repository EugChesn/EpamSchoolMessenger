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
    @IBOutlet weak var notificationCell: UITableViewCell!
    
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLable: UILabel!
    
    @IBAction func editButton(_ sender: Any) {
        viewModel?.editProfile()
    }
    
    @IBOutlet var settingTableView: UITableView!
    
    var viewModel: SettingsViewModeling?
    var router: SettingsRouting?
    private let searchController = UISearchController(searchResultsController: nil)
    private let settingCellId = "SettingCell"
    
    private enum Constant {
        static let rightBarButtonItem = "Edit"
        static let setting = "Settings"
        static let search = "Search"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationItem()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: settingCellId)
        //MARK: SearchBar
        Decor.searchBar(searchController, placeholder: Constant.search)
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        //MARK: Cell setting
        //Decor.styleCell(profileCell)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingCellId, for: indexPath)
        Decor.styleCell(cell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            viewModel?.editProfile()
        }
    }
}

extension SettingsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

extension SettingsViewController: SettingsDelegate {
    func openProfile() {
        router?.routeProfile(withIdentifier: "goToProfile", sender: self)
    }
}
