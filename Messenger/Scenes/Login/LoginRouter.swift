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
    case registrationCodeConfirm
    case createPass
    case setupProfile
    case passwordRecovery
    case codeConfirm
    case newPass
    case mesesnger
}

protocol LoginRoutingLogic {
    func route(routeType: LoginRouteType, from context: UIViewController)
}

class LoginRouter: LoginRoutingLogic {
    
    static var shared: LoginRouter = {
        let instanse = LoginRouter()
        return instanse
    }()
    
    private init() {}
    
    func route(routeType: LoginRouteType, from context: UIViewController) {
        
        switch routeType {
        case .signIn:
            signInRoute(context)
        case .signUp:
            signUpRoute(context)
        case .passwordRecovery:
            passwordRecoveryRoute(context)
        case .codeConfirm:
            codeConfirmRoute(context)
        case .newPass:
            newPassRoute(context)
        case .registrationCodeConfirm:
            registrationCodeConfirmRoute(context)
        case .createPass:
            createPassRoute(context)
        case .setupProfile:
            setupProfileRoute(context)
        case .mesesnger:
            messengerRoute(context)
        }
    }
    
    private func signInRoute(_ context: UIViewController) {
        
        let vcId = LoginRouteType.signIn.rawValue
        let rootVCId = "greeting"
        
        let storyboard = context.storyboard
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: vcId)
            as? SignInViewController,
            let rootVC = storyboard?.instantiateViewController(withIdentifier: rootVCId)
            as? GreetingViewController else { return }
        
        context.navigationController?.popToRootViewController(animated: true)
        rootVC.navigationController?.pushViewController(vc, animated: true)
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
    
    private func codeConfirmRoute(_ context: UIViewController) {
        
        let vcId = LoginRouteType.codeConfirm.rawValue
        
        guard let vc = context.storyboard?.instantiateViewController(withIdentifier: vcId)
            as? CodeConfirmationViewController else { return }
        
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func newPassRoute(_ context: UIViewController) {
        
        let vcId = LoginRouteType.newPass.rawValue
        
        guard let vc = context.storyboard?.instantiateViewController(withIdentifier: vcId)
            as? NewPasswordViewController else { return }
        
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func registrationCodeConfirmRoute(_ context: UIViewController) {
        
        let vcId = LoginRouteType.registrationCodeConfirm.rawValue
        
        guard let vc = context.storyboard?.instantiateViewController(withIdentifier: vcId)
            as? RegistrationCodeConfirmationViewController else { return }
        
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func createPassRoute(_ context: UIViewController) {
        
        let vcId = LoginRouteType.createPass.rawValue
        
        guard let vc = context.storyboard?.instantiateViewController(withIdentifier: vcId)
            as? CreatePasswordViewController else { return }
        
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupProfileRoute(_ context: UIViewController) {
        
        let vcId = LoginRouteType.setupProfile.rawValue
        
        guard let vc = context.storyboard?.instantiateViewController(withIdentifier: vcId)
            as? SetupProfileViewController else { return }
        
        context.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func messengerRoute(_ context: UIViewController) {
        let storyboard = UIStoryboard(name: "Messenger", bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(withIdentifier: "messengerTabBar")
        
        context.navigationController?.pushViewController(tabBarVC, animated: true)
    }
}
