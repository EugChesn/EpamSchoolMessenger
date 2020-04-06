//
//  ChatsObserverExtension.swift
//  Messenger
//
//  Created by Евгений Гусев on 05.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ChatsObserver {
    func downloadChats(completion: @escaping ([ChatInfo]) -> ())
    func observeChats(completion: @escaping (ChatInfo) -> ())
    func removeObservers()
}

extension FirebaseService: ChatsObserver {
    
    //Скачивание всех существующих чатов
    func downloadChats(completion: @escaping ([ChatInfo]) -> ()) {
        guard let uid = getCurrentUser()?.uid else {return}
        
        let chatsReference = referenceDataBase.child("chats").child(uid)
        
        chatsReference.observeSingleEvent(of: .value) { (chatsSnapshot) in
            if let chatInfoDictionary = chatsSnapshot.value as? [String: Any?] {
                
                var chatsInfoList: [ChatInfo] = []
        
                self.referenceDataBase.child("users").observeSingleEvent(of: .value) { (usersSnapshot) in
                    if let usersInfoDictionary = usersSnapshot.value as? [String: Any?] {
                        for key in chatInfoDictionary.keys {
                            var user = Contact()
                            
                            if let userInfo = usersInfoDictionary[key] as? [String: String] {
                                user.name = userInfo["name"] ?? ""
                                user.nickname = userInfo["nickname"] ?? ""
                                user.uid = key
                            }
                            
                            var chat = ChatInfo(contact: user)
                            
                            let chatSnapshot = chatsSnapshot.childSnapshot(forPath: key)
                            
                            chat.lastMessage = chatSnapshot.childSnapshot(forPath: "lastMessage").value as? String ?? ""
                            chat.timeSpan = chatSnapshot.childSnapshot(forPath: "timeSpan").value as? String ?? ""
                            
                            chatsInfoList.append(chat)
                        }
                        
                        completion(chatsInfoList)
                    }
                }
            }
        }
    }
    
    //Добавление листнера на добавление новых чатов или обновление чатов
    func observeChats(completion: @escaping (ChatInfo) -> ()) {
        guard let uid = getCurrentUser()?.uid else {return}
        
        let chatsReference = referenceDataBase.child("chats").child(uid)
        
        let chatsObserverId = chatsReference.observe(.childChanged) { (chatSnapshot) in
            
            //Скачиваем информацию по пользователю для нового или обновленного чата
            self.referenceDataBase.child("users").observeSingleEvent(of: .value) { (usersSnapshot) in
                let userSnapshot = usersSnapshot.childSnapshot(forPath: chatSnapshot.key)

                if let userInfo = userSnapshot.value as? [String: String] {
                    var contact = Contact()

                    contact.uid = chatSnapshot.key
                    contact.name = userInfo["name"] ?? ""
                    contact.nickname = userInfo["nickname"] ?? ""
                    
                    var chat = ChatInfo(contact: contact)
                    
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
