//
//  SettingsRouter.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsRouting {
    func routeProfile(withIdentifier: String, sender: UITableViewController?)
    func routeScreen(withIdentifier: String, sender: UIViewController?)
}

class SettingsRouter: BaseRouter, SettingsRouting {
    func routeProfile(withIdentifier: String, sender: UITableViewController?) {
        performSegue(withIdentifier: withIdentifier, sender: sender)
    }
    
    func routeScreen(withIdentifier: String, sender: UIViewController?) {
        performSegue(withIdentifier: withIdentifier, sender: sender)
    }
}
