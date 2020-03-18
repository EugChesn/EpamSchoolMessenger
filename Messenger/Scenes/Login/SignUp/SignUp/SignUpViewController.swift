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
    
    var viewModel: SignUpViewModeling?
    var router: SignUpRouting?
    
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
    func faultCreateUser(err: Error) {
        if let errorCode = AuthErrorCode(rawValue: err._code) {
            print(errorCode.errorMessage)
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func successCreateUser() {
        router?.routeToProfile(withIdentifier: "profile", sender: self)
    }
    
}
