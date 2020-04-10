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
        fir.downloadChats() { [weak self] chatsList in
            guard let strongSelf = self else {return}
            
            strongSelf.chatsList = chatsList.sorted(by: {$0.timeSpan > $1.timeSpan})
            strongSelf.view?.updateChats()
        }
        
        fir.observeChats() { [weak self] newChat in
            guard let strongSelf = self else {return}
            
            let index = strongSelf.chatsList.firstIndex {$0.contact.uid == newChat.contact.uid
            }

            if let index = index {
                strongSelf.chatsList.remove(at: index)
            }
            
            strongSelf.chatsList.insert(newChat, at: 0)
        
            strongSelf.view?.insertChat(removeIndex: index)
            
            strongSelf.view?.updateChats()
        }
    }
}


