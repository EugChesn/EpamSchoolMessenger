//
//  LoginRouter.swift
//  Messenger
//
//  Created by Евгений Гусев on 12.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

enum LoginRouteType: String {
    case signIn
    case signUp
    case passwordRecovery
}

protocol LoginRoutingLogic {
    
    func perfrom(routeType: LoginRouteType, from context: UIViewController)
    
}

class LoginRouter: LoginRoutingLogic {
    
    static var shared: LoginRouter = {
        let instance =  LoginRouter()

        return instance
    }()

    private init() {}
    
    func perfrom(routeType: LoginRouteType, from context: UIViewController) {
        
        
        switch routeType {
        case .signIn:
            signInRoute(context)
        case .signUp:
            signUpRoute(context)
        case .passwordRecovery:
            passwordRecoveryRoute(context)
        }
    }
    
    private func signInRoute(_ context: UIViewController) {
        
        let vcId = LoginRouteType.signIn.rawValue
        
        guard let vc = context.storyboard?.instantiateViewController(withIdentifier: vcId)
            as? SignInViewController else { return }
        
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func signUpRoute(_ context: UIViewController) {
        
        let vcId = LoginRouteType.signIn.rawValue
        
        guard let vc = context.storyboard?.instantiateViewController(withIdentifier: vcId)
            as? SignUpViewController else { return }
        
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func passwordRecoveryRoute(_ context: UIViewController) {
        
        let vcId = LoginRouteType.signIn.rawValue
        
        guard let vc = context.storyboard?.instantiateViewController(withIdentifier: vcId)
            as? PasswordRecoveryViewController else { return }
        
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
}
