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
    func routeToTable(withIdentifier: String, sender: UITableViewController?)
}

class SettingsRouter: BaseRouter, SettingsRouting {
    func routeToTable(withIdentifier: String, sender: UITableViewController?) {
        performSegue(withIdentifier: withIdentifier, sender: sender)
    }
}
