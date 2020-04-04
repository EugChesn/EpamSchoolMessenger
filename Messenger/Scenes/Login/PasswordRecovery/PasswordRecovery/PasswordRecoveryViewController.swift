//
//  PasswordRecoveryViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

protocol PasswordRecoveryDelegate: class {
    func faultToResetPassword(error: Error)
    func resetSuccess()
}

class PasswordRecoveryViewController: UIViewController {
    var viewModel: PasswordRecoveryViewModeling?
    var router: PasswordRecoveryRouting?
    @IBOutlet weak var emailInputText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDependencies()
    }
    
    
    func setupDependencies() {
        viewModel = PasswordRecoveryViewModel(view: self)
        router = PasswordRecoveryRouter(viewController: self)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        guard let email = emailInputText.text else {
            alertError(errorCode: .invalidEmail)
            return
        }
        if !(viewModel?.isValidEmail(email))!{
            alertError(errorCode: .invalidEmail)
        }
        self.viewModel?.resetPassword(email: email)
        
    }
    
}

extension PasswordRecoveryViewController: PasswordRecoveryDelegate {
    
    func faultToResetPassword(error: Error){
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print(errorCode.errorMessage)
            alertError(errorCode: errorCode)
        }
    }
    func resetSuccess(){
        let alert = UIAlertController(title: "Mail Sent", message: "We have just sent you a password reset e-mail. Please, check your inbox and follow the instructions", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
