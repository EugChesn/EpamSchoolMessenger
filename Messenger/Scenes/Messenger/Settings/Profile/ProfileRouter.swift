//
//  ProfileRouter.swift
//  Messenger
//
//  Created by Анастасия Демидова on 25.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ProfileRoutering {
    func routeSettings()
}

class ProfileRouter: BaseRouter, ProfileRoutering {
    func routeSettings() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
