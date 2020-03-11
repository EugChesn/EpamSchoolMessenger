//
//  SignInRouter.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol PassAutorizationData {
    func passData(autorizationToken: UserToken, destination: UIViewController)
}

class SignInRouter: RoutingLogic, PassAutorizationData {
    func passData(autorizationToken: UserToken, destination: UIViewController) {
        
    }
    
    func perform(to segueId: String, from context: UIViewController) {
        context.performSegue(withIdentifier: segueId, sender: nil)
    }
}
