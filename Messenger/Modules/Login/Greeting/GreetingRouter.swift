//
//  LoginRouter.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

enum GreetingSegue: String {
    case signIn
    case signUp
}

class GreetingRouter: RoutingLogic {
    func perform(to segueId: String, from context: UIViewController) {
       context.performSegue(withIdentifier: segueId, sender: nil)
    }
    
    func popToRootViewController(from context: UIViewController) {
        context.navigationController?.popToRootViewController(animated: true)
    }
}
