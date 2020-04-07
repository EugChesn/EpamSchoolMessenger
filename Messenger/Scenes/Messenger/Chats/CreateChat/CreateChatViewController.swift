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
}

class CreateChatViewController: UIViewController {
    var viewModel: CreateChatViewModeling?
    var router: CreateChatRouting?
    var chatOpenerDelegate: NewChatOpenerDelegate?
    
    @IBOutlet weak var contactListTableView: UITableView!
    @IBOutlet weak var creatChatNavigationItem: UINavigationItem!
    let heightRow: CGFloat = 70
    
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
        let nib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        contactListTableView.register(nib, forCellReuseIdentifier: "ChatCell")
    }
    
    @IBAction func cancelCreate(_ sender: Any) {
        router?.dismiss()
    }
}

extension CreateChatViewController: CreateChatDelegate {
    func updateContactsList() {
        DispatchQueue.main.async {
            self.contactListTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /*DispatchQueue.main.async {
            let myCell = cell as! ChatTableViewCell
            let uidContact = self.viewModel?.contact(atIndex: indexPath.row).uid
            let reference = StorageService.shared.storageRef.child(uidContact!)
            //myCell.photo.sd_setImage(with: reference, placeholderImage: nil)
            StorageService.shared.downloadImage(ref: reference) { image in
                myCell.photo.image = image
            }
        }*/
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell

        let contact = viewModel?.contact(atIndex: indexPath.row)
        cell.nameChat.text = contact?.name
        if let uid = contact?.uid {
            cell.photo.image = viewModel?.getImageContact(uid: uid)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let contact = viewModel?.contact(atIndex: indexPath.row) else {
            return
        }
        
        chatOpenerDelegate?.dialogContact = contact
        router?.dismiss()
    }
    
}
