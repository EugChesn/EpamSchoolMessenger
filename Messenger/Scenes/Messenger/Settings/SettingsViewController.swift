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
    func updateProfile(user:Contact)
}

class SettingsViewController: UITableViewController {
    @IBOutlet private weak var profileCell: UITableViewCell!
    @IBOutlet private weak var notificationCell: UITableViewCell!
    @IBOutlet private weak var languageCell: UITableViewCell!
    @IBOutlet private weak var appearanceCell: UITableViewCell!
    @IBOutlet private weak var infoCell: UITableViewCell!
    @IBOutlet private var settingTableView: UITableView!
    
    @IBAction private func editButton(_ sender: Any) {
        viewModel?.editProfile()
    }
    
    var viewModel: SettingsViewModeling?
    var router: SettingsRouting?
    private let searchController = UISearchController(searchResultsController: nil)
    private let placeHolderImage = UIImage(named: "profile")
    private let settingCellId = "SettingCell"
    private let generalCellId = "General"
    private let infoCellId = "Info"
    
    private enum Constant {
        static let rightBarButtonItem = "Edit"
        static let settings = "Settings"
        static let search = "Search"
        static let notification = "Notification"
        static let language = "Language"
        static let appearance = "Appearance"
        static let information = "Info"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationItem()
        self.registerTableViewCells()
        //MARK: SearchBar
        searchController.searchBarStyle(placeholder: Constant.search)
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        
        setupDependencies()
    }
    
    private func setupDependencies() {
        viewModel = SettingsViewModel(view: self)
        router = SettingsRouter(viewController: self)
    }
    
    private func registerTableViewCells() {
        let profileCell = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        tableView.register(profileCell, forCellReuseIdentifier: settingCellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: generalCellId)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: infoCellId)
    }
    
    private func settingNavigationItem() {
        navigationItem.rightBarButtonItem?.title = Constant.rightBarButtonItem
        navigationItem.title = Constant.settings
        navigationItem.searchController = searchController
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 3
        case 2: return 1
        default:
            fatalError("NoRows")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        switch (indexPath.section) {
        case 0:
            guard let customCell = tableView.dequeueReusableCell(withIdentifier: settingCellId, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
            let contact = viewModel?.contact
            
            customCell.nameLabel.text = viewModel?.userName
            customCell.emailLabel.text = viewModel?.userEmail
            
            let url = contact?.profileImageUrl
            if let urlPhoto = url {
                let reference = StorageService.shared.getReference(url: urlPhoto)
                customCell.profileImage.sd_setImage(with: reference, placeholderImage: placeHolderImage)
            }
            
            cell = customCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: generalCellId, for: indexPath)
            if indexPath.row == 0 {
                cell.textLabel?.text = Constant.notification
            } else if indexPath.row == 1 {
                cell.textLabel?.text = Constant.language
            } else {
                cell.textLabel?.text = Constant.appearance
            }
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: infoCellId, for: indexPath)
            cell.textLabel?.text = Constant.information
        default:
            fatalError("NoCell")
        }
        
        cell.accessoryType = .disclosureIndicator
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
    
    func updateProfile(user:Contact) {
        DispatchQueue.main.async {
            self.settingTableView.reloadData()
        }
    }
}
