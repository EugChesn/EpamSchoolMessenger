//
//  ChatsViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol ChatsViewModeling: ManagersDataFilter {
    var chatsCount: Int {get}
    var selectedChat: ChatInfo? {get set}
    
    func downloadChats()
    func removeObservers()
    func createNewChat(with contact: Contact)
    func getChat(atIndex: Int) -> ChatInfo
    
    func subscribeStateUser()
    func unsubscribeStateUser()
    
    func handlerSearch(searchText: String)
}

protocol ChatInfoGetterDelegate: class {
    var chatInfo: ChatInfo? {get}
}

protocol ManagersDataFilter {
    func remove(offset: Int)
    func insert(offset: Int, element: ChatInfo)
}

class ChatsViewModel: ChatsViewModeling {

    weak var view: ChatsDelegate?
    weak var authService: AuthFirebase?
    
    let firebaseObserver: ChatsObserver = FirebaseService.firebaseService
    
    private var filteredChatsList: [ChatInfo] = []
    private var chatsList: [ChatInfo] = []
    
    private var chat: ChatInfo? {
        didSet {
            DispatchQueue.main.async {
                self.view?.openChat()
            }
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
            return filteredChatsList.count
        }
    }
    
    func getChat(atIndex: Int) -> ChatInfo {
        return filteredChatsList[atIndex]
    }
    
    deinit {
        firebaseObserver.removeObservers()
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
        firebaseObserver.removeObservers()
        chatsList = []
    }
    
    func unsubscribeStateUser() {
        authService?.unListenStateUser()
    }

    func downloadChats() {
        firebaseObserver.downloadChats() { [weak self] chatsList in
            guard let strongSelf = self else {return}
            
            strongSelf.chatsList = chatsList.sorted(by: {$0.timeSpan ?? "" > $1.timeSpan ?? ""})
            strongSelf.filteredChatsList = strongSelf.chatsList
            strongSelf.view?.updateChats()
        }
        
        firebaseObserver.observeChats() { [weak self] newChat in
            guard let strongSelf = self else {return}
            
            let index = strongSelf.chatsList.firstIndex {$0.contact.uid == newChat.contact.uid
            }

            if let index = index {
                strongSelf.filteredChatsList.remove(at: index)
                strongSelf.chatsList.remove(at: index)
            }
            
            strongSelf.filteredChatsList.insert(newChat, at: 0)
            strongSelf.chatsList.insert(newChat, at: 0)
            
            strongSelf.view?.insertChat(removeIndex: index)
        }
    }
    
    func handlerSearch(searchText: String) {
        let valueFilter = chatsList.filter {
            if let name = $0.contact.name {
                if name.hasPrefix(searchText) {
                    return true
                }
            }
            return false
        }
        
        if #available(iOS 13, *) {
            let difference = valueFilter.difference(from: filteredChatsList)
            view?.updateSearchChat(diff: difference)
        } else {
            fatalError("difference need ios 13")
        }
    }
}

extension ChatsViewModel: ManagersDataFilter {
    func remove(offset: Int) {
        filteredChatsList.remove(at: offset)
    }
    
    func insert(offset: Int, element: ChatInfo) {
        filteredChatsList.insert(element, at: offset)
    }
}

