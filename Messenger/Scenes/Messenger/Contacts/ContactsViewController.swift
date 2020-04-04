//
//  ContactsViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol ContactsDelegate: class {
    func updateContactList()
    func setLoginFlow()
}

class ContactsViewController: UIViewController {
    var viewModel: ContactsViewModeling?
    var router: ContactsRouting?
    @IBOutlet weak var contactTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTableView.delegate = self
        contactTableView.dataSource = self
        setupDependencies()
    }
    
    
    func setupDependencies() {
        viewModel = ContactsViewModel(view: self)
        router = ContactsRouter(viewController: self)
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "contactListCell")
        cell.textLabel?.text = viewModel?.getContact(index: indexPath.row).name
       // cell.imageView?.image = viewModel?.getContact(index: indexPath.row).profileImage
        cell.imageView?.image = UIImage(named: "profile")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.contactCount ?? 0
    }
}

extension ContactsViewController: ContactsDelegate {
    
    func updateContactList() {
        DispatchQueue.main.async {
            self.contactTableView.reloadData()
        }
    }
    
    func setLoginFlow() {
        let vsLogin = GreetingViewController.instantiate()
        DispatchQueue.main.async {
            let navBarOnModal: UINavigationController = UINavigationController(rootViewController: vsLogin)
            navBarOnModal.modalPresentationStyle = .fullScreen
            self.present(navBarOnModal, animated: true, completion: nil)
        }
    }}

