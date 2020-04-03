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
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let err = error{
                self.alertError(errorCode: .invalidEmail)
                print(err)
            }
        }
        let alert = UIAlertController(title: "Mail Sent", message: "We have just sent you a password reset e-mail. Please, check your inbox and follow the instructions", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension PasswordRecoveryViewController: PasswordRecoveryDelegate {
    
}
