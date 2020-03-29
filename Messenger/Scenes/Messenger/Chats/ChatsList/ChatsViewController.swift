//
//  ChatsViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol ChatsDelegate: class {
    func updateChats()
}

class ChatsViewController: UIViewController {
    var viewModel: ChatsViewModeling!
    var router: ChatsRouting?
    
    @IBOutlet weak var chatsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupDependencies()
    }
    
    func setupDependencies() {
        viewModel = ChatsViewModel(view: self)
        router = ChatsRouter(viewController: self)
    }
    
    func setupUI() {
        chatsTableView.delegate = self
        chatsTableView.dataSource = self
        
        let searchConroller = UISearchController(searchResultsController: nil)
        searchConroller.searchBar.delegate = self
        navigationItem.searchController = searchConroller
    }
}

extension ChatsViewController: ChatsDelegate {
    func updateChats() {
        DispatchQueue.main.async {
            self.chatsTableView.reloadData()
        }
    }
}

extension ChatsViewController: UISearchBarDelegate {
    
}

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chatsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "chatCellId")
        
        let chat = viewModel.getChat(atIndex: indexPath.row)
        
        cell.textLabel?.text = chat.name
        cell.detailTextLabel?.text = chat.lastMessage
        cell.imageView?.image = UIImage(named: "profile")
        
        return cell
    }
    
    
}
