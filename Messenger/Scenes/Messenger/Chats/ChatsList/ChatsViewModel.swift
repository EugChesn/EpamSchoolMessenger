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
    func removeObservers()
    func createNewChat(with contact: Contact)
    func getChat(atIndex: Int) -> ChatInfo
    
    func subscribeStateUser()
    func unsubscribeStateUser()
}

protocol ChatInfoGetterDelegate: class {
    var chatInfo: ChatInfo? {get}
}

class ChatsViewModel: ChatsViewModeling {

    weak var view: ChatsDelegate?
    weak var authService: AuthFirebase?
    
    let fir: ChatsObserver = FirebaseService.firebaseService
    
    private var chatsList: [ChatInfo] = []
    
    private var chat: ChatInfo? {
        didSet {
            view?.openChat()
        }
    }
    init(view: ChatsDelegate) {
        self.view = view
        self.authService = FirebaseService.firebaseService
        downloadChats()
    }
    
    let chatTransferQueue: DispatchQueue = DispatchQueue.global()
    
    var selectedChat: ChatInfo? {
        get {
            chatTransferQueue.sync {
                return chat
            }
        }
        set {
            guard let selectedChat = newValue else {return}
            chatTransferQueue.sync {
                chat = selectedChat
            }
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
    
    deinit {
        fir.removeObservers()
    }
    
    func createNewChat(with contact: Contact) {
        let chat = ChatInfo(contact: contact)

        selectedChat = chat
    }
    
    func subscribeStateUser() {
        authService?.listenStateUser { state in
            switch state {
            case .NotAuthorised:
                self.view?.setLoginFlow()
            case .Authorised:
                self.doNothing()
            }
        }
    }
    
    func doNothing() {
        
    }
    
    func removeObservers() {
        fir.removeObservers()
        chatsList = []
    }
    
    func unsubscribeStateUser() {
        authService?.unListenStateUser()
    }

    func downloadChats() {
        fir.downloadChats() { chatsList in
            
            var chatsList = chatsList
            
            chatsList.sort { (chat1, chat2) -> Bool in
                if chat1.timeSpan > chat2.timeSpan {
                    return true
                } else {
                    return false
                }
            }
            self.chatsList = chatsList
            
            /*for (index, _) in chatsList.enumerated() {
                let reference = StorageService.shared.storageRef.child(self.chatsList[index].contact.uid)
                StorageService.shared.downloadImage(ref: reference) { (image) in
                    self.chatsList[index].contact.profileImage = image
                    self.view?.updateChats()
                }
            }*/
            self.view?.updateChats()
        }
        
        fir.observeChats() { newChat in
            
            let index = self.chatsList.firstIndex { (chat) -> Bool in
                if chat.contact.uid == newChat.contact.uid {
                    return true
                } else {
                    return false
                }
            }

            if let index = index {
                self.chatsList.remove(at: index)
            }
            
            self.chatsList.insert(newChat, at: 0)
            
            self.view?.insertChat(removeIndex: index)
            
            self.view?.updateChats()
        }
    }
}


