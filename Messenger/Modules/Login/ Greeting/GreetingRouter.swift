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

class GreetingRouter: Router {
    func perform(to segueId: String, from context: UIViewController) {
        guard let route = GreetingSegue(rawValue: segueId) else {
            return
        }
        
        switch route {
        case .signIn:
            let vc = SignInViewController()
            context.navigationController?.pushViewController(vc, animated: true)
        case .signUp:
            let vc = SignUpViewController()
            context.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func popToRootViewController(from context: UIViewController) {
        context.navigationController?.popToRootViewController(animated: true)
    }
}
