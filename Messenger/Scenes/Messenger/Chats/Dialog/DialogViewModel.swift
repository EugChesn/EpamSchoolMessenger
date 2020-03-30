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
    var chat: Chat? {get set}
    
    func message(atIndex: Int) -> MessageModel
}

class DialogViewModel: DialogViewModeling {
    weak var view: DialogDelegate?
    
    private var chatInfo: Chat? {
        didSet {
            messageList = downloadMessages()
        }
    }
    
    private var messageList: [MessageModel] = [] {
        didSet {
            view?.updateChatLog()
        }
    }
    
    var chat: Chat? {
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
    
    func message(atIndex: Int) -> MessageModel {
        return messageList[atIndex]
    }
    
    private func downloadMessages() -> [MessageModel] {
        return [MessageModel(), MessageModel()]
    }
}

struct MessageModel {
    var from: String = "testFrom"
    var to: String = "testTo"
    var text: String = "testText"
    var timeSpan: String = "testTime"
}
