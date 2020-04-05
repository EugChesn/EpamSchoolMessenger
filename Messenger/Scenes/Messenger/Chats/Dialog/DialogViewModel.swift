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
}

class DialogViewModel: DialogViewModeling {
    weak var view: DialogDelegate?
    
    let fir = FirebaseService.firebaseService
    
    private var chatInfo: ChatInfo? {
        didSet {
            downloadMessages()
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
        downloadMessages()
    }
    
    func message(atIndex: Int) -> MessageModel {
        return messageList[atIndex]
    }
    
    func sendMessage(messageText: String) {
        
        if let uid = fir.getCurrentUser()?.uid, let recipientUid = chat?.contact.uid {
            let message = MessageModel(from: uid, to: recipientUid, text: messageText, timeSpan: "")
            
            fir.referenceDataBase.child("chats").child(uid).child(recipientUid).child("thread").childByAutoId().updateChildValues(["from": message.from, "to": message.to, "text": message.text, "timeSpan": message.timeSpan])
            
            fir.referenceDataBase.child("chats").child(uid).child(recipientUid).updateChildValues(["lastMessage": message.text])
            
            if uid != recipientUid {
                fir.referenceDataBase.child("chats").child(recipientUid).child(uid).child("thread").childByAutoId().updateChildValues(["from": message.from, "to": message.to, "text": message.text, "timeSpan": message.timeSpan])
                
                fir.referenceDataBase.child("chats").child(recipientUid).child(uid).updateChildValues(["lastMessage": message.text])
            }  
        }
    }
    
    private func downloadMessages() {
        
        if let uid = fir.getCurrentUser()?.uid, let recipientUid = chat?.contact.uid  {
            fir.referenceDataBase.child("chats").child(uid).child(recipientUid).child("thread").observe(.childAdded) { (snapshot) in
                if let dictionary = snapshot.value as? [String: String] {
                    var message = MessageModel()
                    
                    message.from = dictionary["from"]!
                    message.to = dictionary["to"]!
                    message.text = dictionary["text"]!
                    message.timeSpan = dictionary["timeSpan"]!
                    
                    self.messageList.append(message)
                    self.view?.insertMessage(index: self.messageList.count - 1)
                }
            }
        }
        
    }
}
