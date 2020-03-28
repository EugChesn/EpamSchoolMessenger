//
//  CreateChatModel.swift
//  Messenger
//
//  Created by Admin on 24.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
protocol CreateChatModeling {
    func createNewChat(chatName: String)
}

class CreateChatModel: CreateChatModeling {
    weak var view: CreateChatDelegate?
    weak var chatView: ChatsDelegate?
    private var firebaseService : FirebaseService?
    func createNewChat(chatName: String){
   // let user = firebaseService?.getCurrentUser()
    let chatsDB = firebaseService?.referenceDataBase.database.reference().child("Chats")
        let chatsDictionary = ["name":chatName]
        chatsDB?.childByAutoId().setValue(chatsDictionary)
//        chatsDB?.childByAutoId().setValue(chatsDictionary){ (error, reference) in
//            if let error = error {
//                print(error)
//            }
            self.chatView?.updateTableView()
            //self.view?.chatCreateSuccess()
        }
   // }
    init(view: CreateChatDelegate) {
        self.view = view
    }
}
