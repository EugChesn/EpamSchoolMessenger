//
//  MessagesObserverExtensions.swift
//  Messenger
//
//  Created by Евгений Гусев on 05.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol MessagesObserver {
    func downloadMessages(recipientUid: String, completion: @escaping ([MessageModel]) -> ())
    func observeNewMessages(recipientUid: String, completion: @escaping (MessageModel) -> ())
    func sendMessages(recipientUid: String ,message: MessageModel)
    func removeMessagesObserver()
}

extension FirebaseService: MessagesObserver {
    
    func downloadMessages(recipientUid: String, completion: @escaping ([MessageModel]) -> ()) {
        guard let uid = getCurrentUser()?.uid else {return}
         
        let messagesReference = referenceDataBase.child("chats").child(uid).child(recipientUid)
        
        messagesReference.observeSingleEvent(of: .value) { (snapshot) in
            let thread = snapshot.childSnapshot(forPath: "thread")
            if let dictionary = thread.value as? [String: Any?] {
                
                var messagesList: [MessageModel] = []
                
                for item in dictionary.values {
                    if let messageDictionary = item as? [String: String]{
                        var message = MessageModel()
                        message.fromDictionary(dictionary: messageDictionary)
                        messagesList.append(message)
                    }
                }
                
                completion(messagesList)
            }
        }
    }
    
    func observeNewMessages(recipientUid: String, completion: @escaping (MessageModel) -> ()) {
        
        guard let uid = getCurrentUser()?.uid else {return}
        
        let messagesReference = referenceDataBase.child("chats").child(uid).child(recipientUid).child("thread").queryOrdered(byChild: "timeSpan").queryStarting(atValue: Date().currentTime)
        
        let messageObserverId = messagesReference.observe(.childAdded) { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: String] {
                var message = MessageModel()
                message.fromDictionary(dictionary: dictionary)
                completion(message)
            }
        }
        
        addObserverId(observer: "messagesObserver", id: messageObserverId)
    }
    
    func sendMessages(recipientUid: String, message: MessageModel) {
        guard let uid = getCurrentUser()?.uid else {return}
        
        var message = message
        message.from = uid
        
        let userReference = referenceDataBase.child("chats").child(uid).child(recipientUid)
        
        userReference.child("thread").childByAutoId().updateChildValues(message.asDictionary())
        userReference.updateChildValues(message.asDictionaryForChatInfo())
        
        if uid != recipientUid {
            let recipientReference = referenceDataBase.child("chats").child(recipientUid).child(uid)
            
            recipientReference.child("thread").childByAutoId().updateChildValues(message.asDictionary())
            recipientReference.updateChildValues(message.asDictionaryForChatInfo())
        }
    }
    
    func removeMessagesObserver() {
        removeObserver(observer: "messagesObserver")
    }
}
