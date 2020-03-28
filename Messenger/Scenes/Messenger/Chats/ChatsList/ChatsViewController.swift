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
    func updateTableView()
}

class ChatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var viewModel: ChatsViewModeling?
    var router: ChatsRouting?
    var firebaseService: FirebaseService?
    @IBOutlet weak var searchBarInput: UISearchBar!
    @IBOutlet weak var chatsListTableView: UITableView!
    var chatList = [ChatsList]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatsListTableView.delegate = self
        chatsListTableView.dataSource = self
        chatsListTableView.register(UINib(nibName: "ChatsListTableViewCell", bundle: nil), forCellReuseIdentifier: "chatListCell")
        upgradeChatListTableview()
        setupDependencies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = chatsListTableView.dequeueReusableCell(withIdentifier: "chatListCell", for: indexPath) as? ChatsListTableViewCell else {return UITableViewCell()}
        //refactor last message
        //cell.lastMessageText.text = ""
        cell.chatNamelabel.text = chatList[indexPath.row].chatNameText
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //just for test
        return chatList.count
    }
    
    
    @IBAction func addChatButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    //MARK: TODO
    //refactor this part. Move to Model. Add Image and last message
    
    func upgradeChatListTableview(){
        let chatsDB = firebaseService?.referenceDataBase.database.reference().child("Chats")
        
        chatsDB?.observe(.value, with: { (snapshot) in
            print(snapshot)
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            guard let name = snapshotValue["name"] else {return}
            var chat = ChatsList()
            chat.chatNameText = name
            self.chatList.append(chat)
            self.chatsListTableView.reloadData()
        })             
    }
    
    func setupDependencies() {
        viewModel = ChatsViewModel(view: self)
        router = ChatsRouter(viewController: self)
    }
}

extension ChatsViewController: ChatsDelegate {
    func updateTableView() {
        upgradeChatListTableview()
        //chatsListTableView.reloadData()
    }
}
