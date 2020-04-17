//
//  ChatsObserverExtension.swift
//  Messenger
//
//  Created by Евгений Гусев on 05.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import Firebase

protocol ChatsObserver {
    func downloadChats(completion: @escaping ([ChatInfo]) -> ())
    func observeChats(completion: @escaping (ChatInfo) -> ())
    func removeObservers()
}

extension FirebaseService: ChatsObserver {
    
    //Скачивание всех существующих чатов
    func downloadChats(completion: @escaping ([ChatInfo]) -> ()) {
        guard let uid = currentUser?.uid else {return}
        
        let chatsReference = referenceDataBase.child("chats").child(uid)
        
        chatsReference.observeSingleEvent(of: .value) { (chatsSnapshot) in
            
            self.referenceDataBase.child("users").observeSingleEvent(of: .value) { (usersSnapshot) in
                
                var chatsInfoList: [ChatInfo] = []
                
                for chat in chatsSnapshot.children {

                    let currentChat = chat as! DataSnapshot
                    
                    let userSnapshot = usersSnapshot.childSnapshot(forPath: currentChat.key)
                    
                    let contact = SnapshotDecoder.decode(type: Contact.self, snapshot: userSnapshot.value)
                    
                    if var contact = contact {
                        contact.uid = userSnapshot.key
                        
                        var chatInfo = ChatInfo(contact: contact)
                        
                        chatInfo.lastMessage = currentChat.childSnapshot(forPath: "lastMessage").value as? String
                        chatInfo.timeSpan = currentChat.childSnapshot(forPath: "timeSpan").value as? String
                        
                        chatsInfoList.append(chatInfo)
                    }
                }
                
                completion(chatsInfoList)
            }
        }
    }
    
    //Добавление листнера на добавление новых чатов или обновление чатов
    func observeChats(completion: @escaping (ChatInfo) -> ()) {
        guard let uid = currentUser?.uid else {return}
        
        let chatsReference = referenceDataBase.child("chats").child(uid)
        
        let chatsObserverId = chatsReference.observe(.childChanged) { (chatSnapshot) in
            
            //Скачиваем информацию по пользователю для нового или обновленного чата
            self.referenceDataBase.child("users").child(chatSnapshot.key).observeSingleEvent(of: .value) { (userSnapshot) in

                if var user = SnapshotDecoder.decode(type: Contact.self, snapshot: userSnapshot.value) {

                    user.uid = chatSnapshot.key
                    
                    var chat = ChatInfo(contact: user)
                    
                    chat.lastMessage = chatSnapshot.childSnapshot(forPath: "lastMessage").value as? String ?? ""
                    chat.timeSpan = chatSnapshot.childSnapshot(forPath: "timeSpan").value as? String ?? ""
                    
                    completion(chat)
                }
            }
        }
        
        addObserverId(observer: "newChats", id: chatsObserverId)
    }
    
    func removeObservers() {
        removeObserver(observer: "newChats")
    }
}
