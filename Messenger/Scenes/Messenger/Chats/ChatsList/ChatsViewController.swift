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
}

protocol NewChatOpenerDelegate: class {
    var dialogContact: Contact {get set}
    
    func openNewChat()
}

class ChatsViewController: UIViewController {
    var viewModel: ChatsViewModeling!
    var router: ChatsRouting?
    var handlerState: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var chatsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupDependencies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handlerState = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                let vsLogin = GreetingViewController.instantiate()
                
                DispatchQueue.main.async {
                    let navBarOnModal: UINavigationController = UINavigationController(rootViewController: vsLogin)
                    navBarOnModal.modalPresentationStyle = .fullScreen
                    self.present(navBarOnModal, animated: true, completion: nil)
                }
            } else {
                self.viewModel.downloadChats()
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handlerState!)
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
    
    func openChat() {
        routeToDialog(self)
    }
}
