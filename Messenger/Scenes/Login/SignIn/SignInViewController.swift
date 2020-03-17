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
    @IBOutlet weak var phoneTextField: UITextField!
    
    var backName = ""
    var viewModel: SignInViewModeling?
    var router: SignInRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.title = backName
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        
        phoneTextField.delegate = self
        phoneTextField.becomeFirstResponder()
        
        passwordTextField.delegate = self
        passwordTextField.isHidden = true
        setupDependencies()
    }
    
    @IBAction func LogInTap(_ sender: UIButton) {
        guard let phone = phoneTextField.text else { return }
        //guard let pass = passwordTextField.text else { return }
        viewModel?.sendCodeAuth(phoneNumber: phone)
        passwordTextField.isHidden = false
    }
    
    @IBAction func LogInWithCode(_ sender: UIButton) {
        guard let code = passwordTextField.text else { return }
        viewModel?.handlerLogIn(code: code)
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
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak"
        default:
            return "Unknown error occurred"
        }
    }
}

extension SignInViewController: SignInDelegate {
    func errorLogin(error: Error) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print(errorCode.errorMessage)
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func successLogin() {
        router?.routeToMessage(withIdentifier: "messenger" , sender: self)
    }
}
