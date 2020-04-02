//
//  CreateChatRouter.swift
//  Messenger
//
//  Created by Евгений Гусев on 30.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol CreateChatRouting {
    func dismiss()
}

class CreateChatRouter: BaseRouter, CreateChatRouting {
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
