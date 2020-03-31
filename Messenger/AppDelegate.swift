//
//  AppDelegate.swift
//  Messenger
//
//  Created by Анастасия Демидова on 06.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        navigateStart()
        return true
    }
    
    func navigateStart() {
        let story = UIStoryboard(name: "Messenger", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "StartPoint") as? MessengerTabBarController
        vc?.selectedIndex = 1
        UIApplication.shared.windows.first?.rootViewController = vc
    }
}
