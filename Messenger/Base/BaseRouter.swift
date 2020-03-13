//
//  BaseRouter.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

class BaseRouter {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func performSegue(withIdentifier: String, sender: UIViewController?) {
        viewController?.performSegue(withIdentifier: withIdentifier, sender: sender)
    }
}
