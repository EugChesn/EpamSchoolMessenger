//
//  DialogeViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 15.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol DialogViewModeling: class {
    var messageCount: Int {get}
    var chat: ChatInfo? {get set}
    
    func message(atIndex: Int) -> MessageModel
    func sendMessage(messageText: String)
    func updateChatLog()
    
    func startCheckStatusTimer()
    func stopCheckStatusTimer()
}

class DialogViewModel: DialogViewModeling {
    weak var view: DialogDelegate?
    
    
    weak var firebaseObserver:MessagesObserver? = FirebaseService.firebaseService
    weak var timerFirebase: OnlineStatus? = FirebaseService.firebaseService
    let timerManager: ControlTimer = TimerManager()
    
    private var chatInfo: ChatInfo? {
        didSet {

        }
    }

    private var messageList: [MessageModel] = []
    
    var chat: ChatInfo? {
        get {
            return chatInfo
        }
        set {
            chatInfo = newValue
        }
    }
    
    var messageCount: Int {
        get {
            return messageList.count
        }
    }
    
    init(view: DialogDelegate) {
        self.view = view
    }
    
    func startCheckStatusTimer() {
        timerManager.config(delayedFunc: updateStatusChatUser, interval: 30.0)
        timerManager.start(mode: .common)
        updateStatusChatUser()
    }
    
    func updateStatusChatUser() {
        print("update status chats")
        if let uid = chat?.contact.uid {
            timerFirebase?.checkTime(uid: uid) { result in
                switch result {
                case .success(let time):
                    if let status = Date.getStatusBaseOnTime(newTime: time) {
                        switch status {
                        case StatusUser.Offline.rawValue:
                            print(status)
                            self.chat?.contact.status = status
                            self.view?.updateStatus(status: status)
                        case StatusUser.Online.rawValue:
                            print(status)
                            self.chat?.contact.status = status
                            self.view?.updateStatus(status: status)
                        default:
                            print("error status raw value")
                        }
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    func stopCheckStatusTimer() {
        timerManager.cancelTimerFire()
    }
    
    deinit {
        firebaseObserver?.removeMessagesObserver()
    }
    
    func updateChatLog() {
        downloadMessages()
    }
    
    func message(atIndex: Int) -> MessageModel {
        return messageList[atIndex]
    }
    
    func sendMessage(messageText: String) {
        
        guard let recipientUid = chatInfo?.contact.uid else {return}
        
        let timeSpan = Date().currentTime
        
        let message = MessageModel(from: "", to: recipientUid, text: messageText, timeSpan: timeSpan)
        
        firebaseObserver?.sendMessages(recipientUid: recipientUid, message: message)
    }
    
    
    private func downloadMessages() {
        guard let recipientUid = chatInfo?.contact.uid else {return}
            
        //скачиваем сообщения
            firebaseObserver?.downloadMessages(recipientUid: recipientUid) { [weak self] (messagesList) in
                guard let strongSelf = self else {return}

                strongSelf.messageList = messagesList.sorted(by: {$0.timeSpan < $1.timeSpan})
                strongSelf.view?.updateChatLog()
            }
            
        //после скачивания подписываемся но получение новых сообщений
            firebaseObserver?.observeNewMessages(recipientUid: recipientUid) {[weak self] (message) in
                guard let strongSelf = self else {return}
                
                strongSelf.messageList.append(message)
                strongSelf.view?.insertMessage(index: strongSelf.messageCount - 1)
            }
    }  
}
