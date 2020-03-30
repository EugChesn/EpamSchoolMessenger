//
//  ChatsViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol ChatsViewModeling {
    var chatsCount: Int {get}
    var selectedChat: Chat? {get set}
    
    func getChat(atIndex: Int) -> Chat
}


class ChatsViewModel: ChatsViewModeling {
    
    weak var view: ChatsDelegate?
    
    private var chatsList: [Chat] = [] {
        didSet {
            view?.updateChats()
        }
    }
    
    private var chat: Chat? {
        didSet {
            view?.openChat()
        }
    }
    
    var selectedChat: Chat? {
        get {
            return chat
        }
        set {
            guard let selectedChat = newValue else {return}
            let contains = chatsList.contains { (chat) -> Bool in
                if selectedChat.uid == chat.uid {
                    return true
                } else {
                    return false
                }
            }
            
            if contains {
                chat = selectedChat
            } else {
                chatsList.append(selectedChat)
                chat = selectedChat
            }
        }
    }
    
    var chatsCount: Int {
        get {
            return chatsList.count
        }
    }
    
    func getChat(atIndex: Int) -> Chat {
        let chat = Chat()
        return chat
    }
    
    init(view: ChatsDelegate) {
        self.view = view
        let chat = Chat()
 
        chatsList.append(chat)
        chatsList.append(chat)
        chatsList.append(chat)
    }
    
    private func downLoadChats() -> [Chat] {

        return []
    }
}

struct Chat {
    var lastMessage: String = "test"
    var uid: String = "uid"
    var name: String = "name"
    var profileImage: UIImage?
}

