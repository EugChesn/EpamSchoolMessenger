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
        placeholderView.isHidden = viewModel.chatsCount != 0
        chatsTableView.isHidden = viewModel.chatsCount == 0
        return viewModel.chatsCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(with: ChatTableViewCell.self, for: indexPath)
        if viewModel.chatsCount != 0 {
            let chat = viewModel.getChat(atIndex: indexPath.row)
            cell.nameChat.text = chat.contact.name
            cell.lastMessage.text = chat.lastMessage
            
            if let timeSpan = chat.timeSpan {
                let dateMessage = Date.timeMessageToString(timeSpan)
                cell.timeMessage.text = dateMessage?.getTimeMessage()
            }
            
            if let time = chat.contact.time {
                if let status = Date.getStatusBaseOnTime(newTime: time) {
                    switch status {
                    case StatusUser.Offline.rawValue:
                        cell.statusOnlineImage.backgroundColor = .red
                    case StatusUser.Online.rawValue:
                        cell.statusOnlineImage.backgroundColor = .green
                    default:
                        print("error status user raw value")
                    }
                }
            }
            
            /*if let status = chat.contact.status {
                switch status {
                case StatusUser.Offline.rawValue:
                    cell.statusOnlineImage.backgroundColor = .red
                case StatusUser.Online.rawValue:
                    cell.statusOnlineImage.backgroundColor = .green
                default:
                    print("error status user raw value")
            }
            }*/
 
            
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
