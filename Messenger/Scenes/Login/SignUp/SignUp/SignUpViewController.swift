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
        Utilities.styleButton(signUpButton)
        setupDependencies()
    }
    func setupDependencies() {
        viewModel = SignUpViewModel(view: self)
        router = SignUpRouter(viewController: self)
    }
    private func alertError(errorCode: AuthErrorCode) {
        let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signUpTap(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        guard let pass = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else
        {return}
        
        if Utilities.validatePass(password: pass) {
            viewModel?.registerUser(email: email, password: pass)
        } else {
            alertError(errorCode: .weakPassword)
        }
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
