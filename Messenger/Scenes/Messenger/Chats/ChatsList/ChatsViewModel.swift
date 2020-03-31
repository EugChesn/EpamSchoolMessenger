//
//  ChatsViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol ChatsViewModeling: class {
    var chatsCount: Int {get}
    var selectedChat: ChatInfo? {get set}
    
    func downloadChats()
    func createNewChat(with contact: Contact)
    func getChat(atIndex: Int) -> ChatInfo
}

protocol ChatInfoGetterDelegate: class {
    var chatInfo: ChatInfo? {get}
}


class ChatsViewModel: ChatsViewModeling {
    
    weak var view: ChatsDelegate?
    
    private var chatsList: [ChatInfo] = [] {
        didSet {
            view?.updateChats()
        }
    }
    
    private var chat: ChatInfo? {
        didSet {
            view?.openChat()
        }
    }
    
    var selectedChat: ChatInfo? {
        get {
            return chat
        }
        set {
            guard let selectedChat = newValue else {return}
            
                chat = selectedChat
        }
            
    }
    
    var chatsCount: Int {
        get {
            return chatsList.count
        }
    }
    
    func getChat(atIndex: Int) -> ChatInfo {
        return chatsList[atIndex]
    }
    
    init(view: ChatsDelegate) {
        self.view = view
    }
    
    func createNewChat(with contact: Contact) {
        
            let chat = ChatInfo(contact: contact)
            
            selectedChat = chat
    }
    
    func downloadChats() {
        chatsList = []
        let refDatabase = FirebaseService.firebaseService.referenceDataBase
        if let currentUid = FirebaseService.firebaseService.getCurrentUser()?.uid {
            refDatabase.child("chats").child(currentUid).observe(.childAdded) { (snapshot) in
                let uid = snapshot.key
                let lastMessage = snapshot.childSnapshot(forPath: "lastMessage").value as? String ?? ""
                
                refDatabase.child("users").observe(.childAdded) { (snapshotUsers) in
                    if snapshotUsers.key == uid {
                        if let dictionary = snapshotUsers.value as? [String: String] {
                           
                            
                            var contact = Contact()
                            contact.name = dictionary["name"] ?? ""
                            contact.uid = uid

                            let chat = ChatInfo(lastMessage: lastMessage, contact: contact)
                            self.chatsList.append(chat)
                        }
                    }
                }
            }
        }
    }
}


