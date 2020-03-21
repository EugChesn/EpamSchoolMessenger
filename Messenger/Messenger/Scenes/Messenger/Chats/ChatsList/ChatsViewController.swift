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
    
}

class ChatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewModel: ChatsViewModeling?
    var router: ChatsRouting?
    @IBOutlet weak var searchBarInput: UISearchBar!
    @IBOutlet weak var chatsListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatsListTableView.delegate = self
        chatsListTableView.dataSource = self
        chatsListTableView.register(UINib(nibName: "ChatsListTableViewCell", bundle: nil), forCellReuseIdentifier: "chatListCell")
        setupDependencies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = chatsListTableView.dequeueReusableCell(withIdentifier: "chatListCell", for: indexPath) as? ChatsListTableViewCell else {return UITableViewCell()}
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //just for test
        return 6
    }
    
    func setupDependencies() {
        viewModel = ChatsViewModel(view: self)
        router = ChatsRouter(viewController: self)
    }
    
    //MARK TODO: Get Chat List
}

extension ChatsViewController: ChatsDelegate {
    
}
