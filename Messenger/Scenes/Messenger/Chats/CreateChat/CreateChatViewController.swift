//
//  CreateChatViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 30.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol CreateChatDelegate: class {
    
}

class CreateChatViewController: UIViewController {
    var viewModel: CreateChatViewModeling?
    var router: CreateChatRouting?
    var chatOpenerDelegate: NewChatOpenerDelegate?
    
    @IBOutlet weak var contactListTableView: UITableView!
    @IBOutlet weak var creatChatNavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
        setupUI()
    }
    
    
    func setupDependencies() {
        viewModel = CreateChatViewModel(view: self)
        router = CreateChatRouter(viewController: self)
    }
    
    func setupUI() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        
        
        creatChatNavigationItem.searchController = searchController
        creatChatNavigationItem.title = "test"
        
        contactListTableView.delegate = self
        contactListTableView.dataSource = self
    }
    
    @IBAction func cancelCreate(_ sender: Any) {
        router?.cancelCreate()
    }
}

extension CreateChatViewController: CreateChatDelegate {
    
}

extension CreateChatViewController: UISearchBarDelegate {
    
}

extension CreateChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return  UITableViewCell()
    }
    
    
}
