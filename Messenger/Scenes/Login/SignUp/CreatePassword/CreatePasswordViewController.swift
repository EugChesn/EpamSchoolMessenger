//
//  CreatePasswordViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

class CreatePasswordViewController: UIViewController {
    let viewModel: CreatePasswordViewModeling = CreatePasswordViewModel()
    let router: LoginRoutingLogic = LoginRouter.shared
}
