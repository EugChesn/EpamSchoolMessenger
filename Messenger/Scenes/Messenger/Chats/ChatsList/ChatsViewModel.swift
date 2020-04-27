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
    func clearUD()
    var chatsCount: Int {get}
    var selectedChat: ChatInfo? {get set}
    
    func downloadAndObserveChats()
    func removeObservers()
    func createNewChat(with contact: Contact)
    func getChat(atIndex: Int) -> ChatInfo
    
    
    func subscribeStateUser()
    func unsubscribeStateUser()
    
    func handlerSearch(searchText: String)
    
    func startCheckTimerTime()
    func stopCheckTimerTime()
    
    func setTimeSelectedChatList(time: String)
    
    func observeChats()
    
    func removeChatListForSignOut()
}

protocol ChatInfoGetterDelegate: class {
    var chatInfo: ChatInfo? {get}
}

class ChatsViewModel: ChatsViewModeling {

    weak var view: ChatsDelegate?
    weak var authService: AuthFirebase?
    weak var onlineFirebase: OnlineStatus?
    
    let firebaseObserver: ChatsObserver = FirebaseService.firebaseService
    let timerManager: ControlTimer = TimerManager()
    
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
        self.onlineFirebase = FirebaseService.firebaseService
        downloadAndObserveChats()
    }
    
    /*deinit {
        firebaseObserver.removeObservers()
    }*/
    
    func setTimeSelectedChatList(time: String) {
        if let chat = chat {
            if let index = chatsList.firstIndex(of: chat) {
                //chatsList[index].contact.status = status
                chatsList[index].contact.time = time
                view?.updateSearch()
            }
        }
    }
    
    func startCheckTimerTime() {
        timerManager.config(delayedFunc: updateTimeUser, interval: 60.0)
        timerManager.start(mode: .common)
        updateTimeUser()
    }
    
    func stopCheckTimerTime() {
        timerManager.cancelTimerFire()
    }
    
    private func updateTimeUser() {
        print("update time")
        onlineFirebase?.writeTimeOnlineCurrUser(status: .Online) { result in
            switch result {
            case .success( _):
                print("good update time")
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
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
            if view!.isFiltering {
                return filteredChatsList.count
            } else {
                return chatsList.count
            }
        }
    }
    
    func getChat(atIndex: Int) -> ChatInfo {
        if view!.isFiltering {
            return filteredChatsList[atIndex]
        } else {
            return chatsList[atIndex]
        }
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
        //chatsList = []
    }
    func removeChatListForSignOut() { // так как chatsviewcontroller is root
        chatsList = []
        view?.updateChats()
    }
    
    func clearUD() {
        UserSettings.clear(for: AppearanceKey.imageBackgroundChat)
        UserSettings.clear(for: ProfileSetting.birthday)
    }
    
    func unsubscribeStateUser() {
        authService?.unListenStateUser()
    }
    
    func observeChats() {
        firebaseObserver.observeChats() { [weak self] newChat in
            guard let strongSelf = self else {return}
            
            let index = strongSelf.chatsList.firstIndex {$0.contact.uid == newChat.contact.uid
            }

            if let index = index {
                strongSelf.chatsList.remove(at: index)
            }
            strongSelf.chatsList.insert(newChat, at: 0)
            
            strongSelf.view?.insertChat(removeIndex: index)
        }
    }

    func downloadAndObserveChats() {
        firebaseObserver.downloadChats() { [weak self] chatsList in
            guard let strongSelf = self else {return}
            
            strongSelf.chatsList = chatsList.sorted(by: {$0.timeSpan ?? "" > $1.timeSpan ?? ""})
            strongSelf.view?.updateChats()
        }
        
        observeChats()
    }
    
    
    func handlerSearch(searchText: String) {        
        let valueFilter = chatsList.filter {
            if let name = $0.contact.name {
                if let _ = name.range(of: searchText, options: .caseInsensitive) {
                    return true
                } else {
                    return false
                }
            }
            return false
        }
        
        
        filteredChatsList = valueFilter
        view?.updateSearch()
    }
}

