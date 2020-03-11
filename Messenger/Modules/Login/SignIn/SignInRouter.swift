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

class SignInRouter: Router {
    func perform(to segueId: String, from context: UIViewController) {
        guard let route = SignInSegue(rawValue: segueId) else {
            return
        }
        
        switch route {
        case .login:
            print(route)
        case .passwordRecovery:
            let vc = PasswordRecoveryViewController()
            context.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func popToRootViewController(from context: UIViewController) {
        
    }
}
