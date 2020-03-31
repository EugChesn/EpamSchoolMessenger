//
//  ChatListTableViewExtension.swift
//  Messenger
//
//  Created by Евгений Гусев on 31.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.chatsCount)
        return viewModel.chatsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "chatCellId")
        if viewModel.chatsCount != 0 {
            let chat = viewModel.getChat(atIndex: indexPath.row)
            
            cell.textLabel?.text = chat.contact.name
            cell.detailTextLabel?.text = chat.lastMessage
            cell.imageView?.image = UIImage(named: "profile")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedChat = viewModel.getChat(atIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
