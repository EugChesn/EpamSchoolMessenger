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
    
    //Стягивает предыдущую историю сообщений
    func downloadMessages(recipientUid: String, completion: @escaping ([MessageModel]) -> ()) {
        guard let uid = getCurrentUser()?.uid else {return}
         
        let messagesReference = referenceDataBase.child("chats").child(uid).child(recipientUid)
        
        messagesReference.observeSingleEvent(of: .value) { (snapshot) in
            let thread = snapshot.childSnapshot(forPath: "thread")
            if let dictionary = thread.value as? [String: Any?] {
                
                var messagesList: [MessageModel] = []

                //В словаре dictionary храняться значения в виде (key) id сообщения: (item) тело сообщения вида [String:String].
                for item in dictionary.values {
                    let message = SnapshotDecoder.decode(type: MessageModel.self, snapshot: item)
                    
                    if let message = message {
                        messagesList.append(message)
                    }
                }
                
                completion(messagesList)
            }
        }
    }
    
    //Подписка на получение новых сообщений
    func observeNewMessages(recipientUid: String, completion: @escaping (MessageModel) -> ()) {
        
        guard let uid = getCurrentUser()?.uid else {return}
        
        let messagesReference = referenceDataBase.child("chats").child(uid).child(recipientUid).child("thread").queryOrdered(byChild: "timeSpan").queryStarting(atValue: Date().currentTime)
        
        let messageObserverId = messagesReference.observe(.childAdded) { (snapshot) in
            
            if let message =  SnapshotDecoder.decode(type: MessageModel.self, snapshot: snapshot.value) {

                completion(message)
            }
        }
        
        addObserverId(observer: "messagesObserver", id: messageObserverId)
    }
    
    //Добавляет сообщение в thread чата юзера и получателя
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
