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
    func openChat()
}

protocol NewChatOpenerDelegate: class {
    var dialogContact: Contact {get set}
    
    func openNewChat()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.downloadChats()
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
        navigationItem.title = "Chats"

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createChat" {
            if let destination = segue.destination as? CreateChatViewController {
                destination.chatOpenerDelegate = self
            }
        }
        if segue.identifier == "dialog" {
            if let destination = segue.destination as? DialogViewController {
                    destination.chatInfo = viewModel.selectedChat
            }
        }
    }
    
    func routeToDialog(_ sender: Any) {
        router?.routeToDialog()
    }
    
    @IBAction func routeToCreateChat(_ sender: Any) {
        router?.routeToCreateChat()
    }
    
    @IBAction func signOut(_ sender: Any) {
        router?.signOut()
    }
}

extension ChatsViewController: ChatsDelegate {
    func updateChats() {
        DispatchQueue.main.async {
            self.chatsTableView.reloadData()
        }
    }
    
    func openChat() {
        routeToDialog(self)
    }
}
