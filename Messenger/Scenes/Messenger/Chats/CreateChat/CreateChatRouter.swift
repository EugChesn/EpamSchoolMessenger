//
//  CreateChatRouter.swift
//  Messenger
//
//  Created by Евгений Гусев on 30.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol CreateChatRouting {
    func cancelCreate()
    func createChat()
}

class CreateChatRouter: BaseRouter, CreateChatRouting {
    func cancelCreate() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func createChat() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
