//
//  AddContactRouter.swift
//  Messenger
//
//  Created by Admin on 18.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
protocol AddContactRouting {
    func dismiss()
}

class AddContactRouter: BaseRouter, AddContactRouting {
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
