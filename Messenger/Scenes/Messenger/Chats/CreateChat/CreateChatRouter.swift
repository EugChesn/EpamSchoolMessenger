//
//  CreateChatRouter.swift
//  Messenger
//
//  Created by Евгений Гусев on 30.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol CreateChatRouting {
    func routeToBackInChats()
}

class CreateChatRouter: BaseRouter, CreateChatRouting {
    func routeToBackInChats() {
        //viewController?.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "cancelCreate", sender: viewController)
    }
}
