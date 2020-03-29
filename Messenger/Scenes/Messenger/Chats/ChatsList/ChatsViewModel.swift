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
    
    func getChat(atIndex: Int) -> Chat
}

class ChatsViewModel: ChatsViewModeling {
    
    weak var view: ChatsDelegate?
    
    var chatsList: [Chat] = []
    
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

