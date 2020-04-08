//
//  ChatListTableViewExtension.swift
//  Messenger
//
//  Created by Евгений Гусев on 31.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chatsCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRow
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /*DispatchQueue.main.async {
            let myCell = cell as! ChatTableViewCell
            if self.viewModel.chatsCount != 0 {
                let chat = self.viewModel.getChat(atIndex: indexPath.row)
                //let reference = StorageService.shared.storageRef.child(chat.contact.uid)
                if let url = chat.contact.profileImageUrl {
                    let reference = StorageService.shared.getReference(url: url)
                    myCell.photo.sd_setImage(with: reference, placeholderImage: nil)
                }
            }
        }*/
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(with: ChatTableViewCell.self, for: indexPath)
        if viewModel.chatsCount != 0 {
            let chat = viewModel.getChat(atIndex: indexPath.row)
            cell.nameChat.text = chat.contact.name
            cell.lastMessage.text = chat.lastMessage
            
        
            if let url = chat.contact.profileImageUrl {
                let reference = StorageService.shared.getReference(url: url)
                cell.photo.sd_setImage(with: reference, placeholderImage: placeHolderImage)
            }
                
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedChat = viewModel.getChat(atIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
