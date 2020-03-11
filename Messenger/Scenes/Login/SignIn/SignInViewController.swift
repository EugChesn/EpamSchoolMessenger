//
//  SignInViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
    private let signInRouter = SignInRouter()
    let signInViewModel = SignInViewModel()
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func autorize(_ sender: Any) {
        guard let number = numberTextField.text,
            let pass = passwordTextField.text else { return }
        
        let isAutorize = signInViewModel.login(number: number,
                                               password: pass)
        
        if (isAutorize) {
            signInRouter.perform(to: "messenger", from: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messenger" {
            if let destinition = segue.destination as? MessengerTabBarController {
                let token = signInViewModel.getToken()
                signInRouter.passData(autorizationToken: token, destination: destinition)
            }
        }
    }
}
