//
//  ChatInfoTransferExtension.swift
//  Messenger
//
//  Created by Евгений Гусев on 31.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol NewChatOpenerDelegate: class {
    var dialogContact: Contact {get set}
    func openNewChat()
}

extension ChatsViewController: NewChatOpenerDelegate {
    var dialogContact: Contact {
        get {
            return Contact()
        }
        set {
            viewModel.createNewChat(with: newValue)
        }
    }
    
    func openNewChat() {
        openChat()
    }
}
