//
//  MessengerRouter.swift
//  Messenger
//
//  Created by Евгений Гусев on 12.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

enum MessengerRouteType: String {
    case chat
    case logOut
}

protocol MessengerRoutingLogic {
    func perfrom(routeType: MessengerRouteType, from context: UIViewController)
}

class MessengerRouter: MessengerRoutingLogic {
    
    static var shared: MessengerRouter = {
        let instance =  MessengerRouter()

        return instance
    }()

    private init() {}
    
    func perfrom(routeType: MessengerRouteType, from context: UIViewController) {
        
        switch routeType {
        case .chat:
            chatRoute(context)
        case .logOut:
            logOut(context)
        }
    }
    
    private func chatRoute(_ context: UIViewController) {
        
    }
    
    private func logOut(_ context: UIViewController) {
        context.tabBarController?.navigationController?.popToRootViewController(animated: true)
    }
    
}
