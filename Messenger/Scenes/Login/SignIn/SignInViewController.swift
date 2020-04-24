//
//  SignInViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

protocol SignInDelegate: class {
    func successLogin()
    func errorLogin(error: Error)
}

class SignInViewController: UIViewController {
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    var backName = ""
    var viewModel: SignInViewModeling?
    var router: SignInRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.styleTextField(placeholder: "Email", colorLine: "3B8AC4")
        passwordTextField.styleTextField(placeholder: "Password", colorLine: "3B8AC4")
        logInButton.styleButton()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setupDependencies()
    }
    
    @IBAction func LogInTap(_ sender: UIButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let pass = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        if !email.isValidateEmail() {
            alertError(errorCode: .invalidEmail)
        } else if !pass.isValidatePass() {
            alertError(errorCode: .weakPassword)
        } else {
            viewModel?.signInHandler(email: email, pass: pass)
            let activity = ManagerActivityIndicator.styleActivity(message: "Login..", type: .ballClipRotate)
            ManagerActivityIndicator.startAnimating(activity: activity)
        }
    }
    
    func setupDependencies() {
        viewModel = SignInViewModel(view: self)
        router = SignInRouter(viewController: self)
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        router?.routeToPasswordReset()
    }
    
}

extension SignInViewController: UITextFieldDelegate {
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

extension SignInViewController: SignInDelegate {
    func errorLogin(error: Error) {
        ManagerActivityIndicator.stopAnimating()
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print(errorCode.errorMessage)
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindLogin"{
            if let destination = segue.destination as? ChatsViewController {
                destination.viewModel.downloadAndObserveChats()
            }
        }
    }
  
    func successLogin() {
        ManagerActivityIndicator.stopAnimating()
        router?.routeToMessage(withIdentifier: "unwindLogin" , sender: self)
    }
}

