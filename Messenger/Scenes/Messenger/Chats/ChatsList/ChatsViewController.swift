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
                destination.chatViewModel = viewModel
            }
        }
    }
    
    func routeToDialog(_ sender: Any) {
        performSegue(withIdentifier: "dialog", sender: sender)
    }
    
    @IBAction func routeToCreateChat(_ sender: Any) {
        performSegue(withIdentifier: "createChat", sender: sender)
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

extension ChatsViewController: NewChatOpenerDelegate {
    var dialogContact: Contact {
        get {
            return Contact()
        }
        set {
            viewModel.createNewChat(with: newValue)
        }
    }
    
    func openNewChat() {
        openChat()
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
        
        cell.textLabel?.text = chat.contact.name
        cell.detailTextLabel?.text = chat.lastMessage
        cell.imageView?.image = UIImage(named: "profile")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedChat = viewModel.getChat(atIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
