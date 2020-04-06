//
//  DialogeViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 15.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol DialogViewModeling {
    var messageCount: Int {get}
    var chat: ChatInfo? {get set}
    
    func message(atIndex: Int) -> MessageModel
    func sendMessage(messageText: String)
    func updateChatLog()
}

class DialogViewModel: DialogViewModeling {
    weak var view: DialogDelegate?
    
    let fir:MessagesObserver = FirebaseService.firebaseService
    
    private var chatInfo: ChatInfo? {
        didSet {

        }
    }
    let queque = DispatchQueue.global()
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
    
    deinit {
        fir.removeMessagesObserver()
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
        
        fir.sendMessages(recipientUid: recipientUid, message: message)
    }
    
    private func downloadMessages() {
        guard let recipientUid = chatInfo?.contact.uid else {return}
        
            fir.downloadMessages(recipientUid: recipientUid) { [weak self] (messagesList) in
                guard let strongSelf = self else {return}
                var messagesList = messagesList
                
                messagesList.sort { (message1, message2) -> Bool in
                    if message1.timeSpan < message2.timeSpan {
                        return true
                    } else {
                        return false
                    }
                }
                
                strongSelf.messageList = messagesList
                strongSelf.view?.updateChatLog()
            }
            
            fir.observeNewMessages(recipientUid: recipientUid) {[weak self] (message) in
                guard let strongSelf = self else {return}
                
                strongSelf.messageList.append(message)
                strongSelf.view?.insertMessage(index: strongSelf.messageCount - 1)
            }
    }  
}
