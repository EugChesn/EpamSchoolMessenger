//
//  SignUpViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpDelegate: class {
    func successCreateUser()
}

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel: SignUpViewModeling?
    var router: SignUpRouting?
    private var flagSuccessRegister = false {
        willSet {
            if newValue {
                router?.routeToProfile(withIdentifier: "profile", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDependencies()
    }
    
    @IBAction func signUpTap(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        guard let pass = passwordTextField.text else {return}
        viewModel?.registerUser(email: email, password: pass)
    }
    
    func setupDependencies() {
        viewModel = SignUpViewModel(view: self)
        router = SignUpRouter(viewController: self)
    }
}

extension SignUpViewController: SignUpDelegate {
    func successCreateUser() {
        flagSuccessRegister = true
    }
}
