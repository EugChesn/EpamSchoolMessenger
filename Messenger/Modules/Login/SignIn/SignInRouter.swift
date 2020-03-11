//
//  SignInRouter.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

enum SignInSegue: String {
    case login
    case passwordRecovery
}

class SignInRouter: RoutingLogic {
    func perform(to segueId: String, from context: UIViewController) {
        context.performSegue(withIdentifier: segueId, sender: nil)
    }
    
    func popToRootViewController(from context: UIViewController) {
        
    }
}
