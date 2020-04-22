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
    func updateContactsList()
    
    func updateSearch()
    var searchBarIsEmpty: Bool {get}
    var isFiltering: Bool {get}
}

class CreateChatViewController: UIViewController {
    var viewModel: CreateChatViewModeling?
    var router: CreateChatRouting?
    var chatOpenerDelegate: NewChatOpenerDelegate?
    
    @IBOutlet weak var contactListTableView: UITableView!
    //@IBOutlet weak var creatChatNavigationItem: UINavigationItem!
    let heightRow: CGFloat = 70
    let placeHolderImage = UIImage(named: "profile")
    var indexContact: Int!
    
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
        
        setupDependencies()
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cancelCreate" {
            if let destination = segue.destination as? ChatsViewController {
                if let index = indexContact {
                    if let contact = viewModel?.contact(atIndex: index) {
                        destination.dialogContact = contact
                    }
                }
            }
        }
    }
    
    func setupDependencies() {
        viewModel = CreateChatViewModel(view: self)
        router = CreateChatRouter(viewController: self)
    }
    
    func setupUI() {
        contactListTableView.delegate = self
        contactListTableView.dataSource = self
        contactListTableView.register(cellType: ChatCell.self)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
        //navigationItem.searchController = searchController
        //creatChatNavigationItem.searchController = searchController
        navigationItem.searchController = searchController
        navigationItem.title = "New Message"
    }
    
    @IBAction func cancelCreate(_ sender: Any) {
        //router?.dismiss()
    }
}

extension CreateChatViewController: CreateChatDelegate {
    func updateContactsList() {
        DispatchQueue.main.async {
            self.contactListTableView.reloadData()
        }
    }
    
    func updateSearch() {
        DispatchQueue.main.async {
            self.contactListTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
}

extension CreateChatViewController: UISearchBarDelegate {
    
}

extension CreateChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.contactsCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ChatCell.self, for: indexPath)
        let contact = viewModel?.contact(atIndex: indexPath.row)
        cell.nameChat.text = contact?.name ?? "Unnamed"
        
        let url = contact?.profileImageUrl
        if let urlPhoto = url {
            let reference = StorageService.shared.getReference(url: urlPhoto)
            cell.photo.sd_setImage(with: reference, placeholderImage: placeHolderImage)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexContact = indexPath.row
        router?.routeToBackInChats()
    }
    
}
