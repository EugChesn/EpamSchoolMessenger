//
//  ChatsRouter.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ChatsRouting {
    func routeToDialog()
    func routeToCreateChat()
    func signOut()
}

class ChatsRouter: BaseRouter, ChatsRouting {
    func routeToDialog() {
        performSegue(withIdentifier: "dialog", sender: viewController)
    }
    
    func routeToCreateChat() {
        performSegue(withIdentifier: "createChat", sender: viewController)
    }
    
    func signOut() {
        viewController?.tabBarController?.navigationController?.popToRootViewController(animated: true)
        
        
        let fir: AuthFirebase = FirebaseService.firebaseService
        fir.signOutUser()
    }
}
