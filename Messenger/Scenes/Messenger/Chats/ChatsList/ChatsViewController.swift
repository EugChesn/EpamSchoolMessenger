//
//  ChatsViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

protocol ChatsDelegate: class {
    func updateChats()
    func openChat()
    func setLoginFlow()
    func insertChat(removeIndex: Int?)
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
        viewModel.subscribeStateUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateChats()
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
    @IBAction func unwindSegueChat(_ unwindSegue: UIStoryboardSegue) { }
    
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
        if segue.identifier == "unwindLogin" {
            // ...
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
    
    func insertChat(removeIndex: Int?) {
        DispatchQueue.main.async {
            self.chatsTableView.beginUpdates()
            if let removeIndex = removeIndex {
                self.chatsTableView.deleteRows(at: [IndexPath(row: removeIndex, section: 0)], with: .fade)
            }
            self.chatsTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            self.chatsTableView.endUpdates()
        }
    }
    
    func openChat() {
        routeToDialog(self)
    }
    func setLoginFlow() {
        let vsLogin = GreetingViewController.instantiate()
        DispatchQueue.main.async {
            let navBarOnModal: UINavigationController = UINavigationController(rootViewController: vsLogin)
            navBarOnModal.modalPresentationStyle = .fullScreen
            self.present(navBarOnModal, animated: true, completion: nil)
        }
    }
}




