//
//  CreateChatRouter.swift
//  Messenger
//
//  Created by Admin on 24.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol CreateChatRouting {
    func routeToCreatedChat(withIdentifier: String, sender: UIViewController?)
}

class CreateChatRouter: BaseRouter, CreateChatRouting {
    func routeToCreatedChat(withIdentifier: String, sender: UIViewController?) {
        performSegue(withIdentifier: withIdentifier, sender: sender)
    }
}
