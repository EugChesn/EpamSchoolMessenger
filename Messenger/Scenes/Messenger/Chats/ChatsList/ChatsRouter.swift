//
//  ChatsRouter.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol ChatsRouting {
    func routeToSelectedChat(withIdentifier: String, sender: UIViewController?)
}

class ChatsRouter: BaseRouter, ChatsRouting {
    func routeToSelectedChat(withIdentifier: String, sender: UIViewController?) {
        performSegue(withIdentifier: withIdentifier, sender: sender)
    }
}
