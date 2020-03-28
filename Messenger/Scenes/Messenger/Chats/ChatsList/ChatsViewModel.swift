//
//  ChatsViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ChatsViewModeling {
  //  func updateChatList() -> String
}

class ChatsViewModel: ChatsViewModeling {
    weak var view: ChatsDelegate?
    private var firebaseService : FirebaseService?
    init(view: ChatsDelegate) {
        self.view = view
    }
    //TODO
//    func updateChatList() -> String{
//        var chatName = ""
//        let chatsDB = firebaseService?.referenceDataBase.database.reference().child("Chats")
//        chatsDB?.observe(.childAdded) { (snapshot) in
//            let snapshotValue = snapshot.value as! Dictionary<String, String>
//            guard let name = snapshotValue["name"] else {return}
//            chatName = name
//        }
//        return chatName
//    }
}
