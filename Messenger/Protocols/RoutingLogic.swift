//
//  Router.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol RoutingLogic {
    func perform(to segueId: String, from context: UIViewController)
}

protocol PopRoutingLogic: RoutingLogic {
    func popToRootViewController(from context: UIViewController)
}


