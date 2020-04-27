//
//  AppearanceRouter.swift
//  Messenger
//
//  Created by Анастасия Демидова on 26.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol AppearanceRoutering {
    func routeSettings()
}

class AppearanceRouter: BaseRouter, AppearanceRoutering {
    func routeSettings() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
