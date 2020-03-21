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
    weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func performSegue(withIndetifier: String, sender: UIViewController?) {
        
    }
}
