//
//  SignUpViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

protocol SignUpDelegate: class {
    func successCreateUser()
    func faultCreateUser(err: Error)
}

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var viewModel: SignUpViewModeling?
    var router: SignUpRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleButton(signUpButton)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setupDependencies()
    }
    func setupDependencies() {
        viewModel = SignUpViewModel(view: self)
        router = SignUpRouter(viewController: self)
    }
    
    @IBAction func signUpTap(_ sender: UIButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let pass = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)  else { return }
        
        if !email.isValidateEmail() {
            alertError(errorCode: .invalidEmail)
        } else if !pass.isValidatePass() {
            alertError(errorCode: .weakPassword)
        } else {
            viewModel?.registerUser(email: email, password: pass)
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == passwordTextField) {
            let currentText = textField.text! + string
            if !(currentText.count <= Utilities.maxLenPassword) {
                textField.shake()
                return false
            }
        } else if (textField == emailTextField) {
            let currentText = textField.text! + string
            if !(currentText.count <= Utilities.maxLenEmail) {
                textField.shake()
                return false
            }
        }
        
        return true;
    }
}

extension SignUpViewController: SignUpDelegate {
    func faultCreateUser(err: Error) {
        if let errorCode = AuthErrorCode(rawValue: err._code) {
            print(errorCode.errorMessage)
            alertError(errorCode: errorCode)
        }
    }
    func successCreateUser() {
        router?.routeToProfile(withIdentifier: "profile", sender: self)
    }
}
