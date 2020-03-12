//
//  SignUpViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    let viewModel: SignUpViewModeling = SignUpViewModel()
    let router: LoginRoutingLogic = LoginRouter.shared
}
