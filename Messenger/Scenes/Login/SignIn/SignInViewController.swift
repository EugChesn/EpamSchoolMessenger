//
//  SignInViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol SignInDelegate: class {
    
}

class SignInViewController: UIViewController {
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var viewModel: SignInViewModeling?
    var router: SignInRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    
    @IBAction func LogInTap(_ sender: UIButton) { // route to chat view
    }
    
    @IBAction func ForgotPasswordTap(_ sender: UIButton) { // route to greeting view

    }
    func setupDependencies() {
        viewModel = SignInViewModel(view: self)
        router = SignInRouter(viewController: self)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            phoneTextField.becomeFirstResponder()
        }
        return true
    }
}

extension SignInViewController: SignInDelegate {
    
}
