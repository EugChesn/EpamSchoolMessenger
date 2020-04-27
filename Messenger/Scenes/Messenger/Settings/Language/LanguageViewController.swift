//
//  LanguageViewController.swift
//  Messenger
//
//  Created by Анастасия Демидова on 20.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol LanguageDelegete: class {
    
}

class LanguageViewController: UIViewController {
    var viewModel: LanguageViewModeling?
    var router: LanguageRoutering?
    
    private enum Constant {
        static let titleSection = "Language App"
        static let enLanguage = "English"
        static let ruLanguage = ["Russian","Русский"]
    }
    
    @IBOutlet weak var languageNavigationBar: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setupDependencies()
    }
    
    private func setupDependencies() {
        viewModel = LanguageViewModel(view: self)
        router = LanguageRouter(viewController: self)
    }
}

//MARK: TableView
extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constant.titleSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let leguageCode = viewModel?.lenguage
        
        if indexPath.row == 0 {
            if leguageCode == "en" {
                cell.accessoryType = .checkmark
            }
            cell.textLabel?.text = Constant.enLanguage
            cell.detailTextLabel?.text = Constant.enLanguage
        } else {
            if leguageCode == "ru" {
                cell.accessoryType = .checkmark
            }
            cell.textLabel?.text = Constant.ruLanguage[0]
            cell.detailTextLabel?.text = Constant.ruLanguage[1]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension LanguageViewController: LanguageDelegete {
    
}
