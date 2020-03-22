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
    
}

class SettingsViewController: UIViewController {
    var viewModel: SettingsViewModeling?
    var router: SettingsRouting?
    
    private enum Title {
        static let setting = "Settings"
        static let rightBarButtonItem = "Edit"
        static let search = "Search"
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem?.title = Title.rightBarButtonItem
        searchBar.placeholder = Title.search
        searchBar.delegate = self
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

extension SettingsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        searchBar.searchTextField.text = nil
    }
}

extension SettingsViewController: SettingsDelegate {
    
}
