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
    func setLoginFlow()
    func insertChat(removeIndex: Int?)

    func updateSearch()
    var searchBarIsEmpty: Bool {get}
    var isFiltering: Bool {get}
    
}

protocol NewChatOpenerDelegate: class {
    var dialogContact: Contact {get set}
    func openNewChat()
}

class ChatsViewController: UIViewController {
    var viewModel: ChatsViewModeling!

    var router: ChatsRouting?
    
    @IBOutlet weak var chatsTableView: UITableView!
    let heightRow: CGFloat = 70
    let placeHolderImage = UIImage(named: "profile")
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDependencies()
        viewModel.startCheckTimerTime()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.subscribeStateUser()
        viewModel.ObserveChats()
        //updateChats()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.removeObservers()
        viewModel.unsubscribeStateUser()
    }
    
    func setupDependencies() {
        viewModel = ChatsViewModel(view: self)
        router = ChatsRouter(viewController: self)
    }
    
    
    func setupUI() {
        chatsTableView.delegate = self
        chatsTableView.dataSource = self
        chatsTableView.register(cellType: ChatTableViewCell.self)
        chatsTableView.keyboardDismissMode = .onDrag
        
        //Fix bar with search bar
        /*let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance*/
        //
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
        
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
                destination.closureBackTime = { [weak self] time in
                    self?.viewModel.setTimeSelectedChatList(time: time)
                }
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
        viewModel.removeChatListForSignOut()
        viewModel.removeObservers()
    }
}

extension ChatsViewController: ChatsDelegate {
    func updateSearch() {
        DispatchQueue.main.async {
            self.chatsTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    func updateChats() {
        DispatchQueue.main.async {
            self.chatsTableView.reloadData()
        }
    }
    
    /*func updateStatus(atIndex: Int, status: StatusUser) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: atIndex, section: 0)
            if let currCell = self.chatsTableView.cellForRow(at: indexPath) as? ChatTableViewCell{
                switch status {
                case .Offline:
                    currCell.statusOnlineImage.backgroundColor = .red
                case .Online:
                    currCell.statusOnlineImage.backgroundColor = .green
                }
            }
            self.chatsTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }*/
    
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




