//
//  SignInViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol SignInViewModeling {
    func sendCodeAuth(phoneNumber: String)
    func handlerLogIn(code: String)
}

class SignInViewModel: SignInViewModeling {
    var view: SignInDelegate?
    
    init(view: SignInDelegate) {
        self.view = view
    }
    
    func sendCodeAuth(phoneNumber: String) {
        //Auth.auth().settings!.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print(error.localizedDescription)
              return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        }
    }
    
    func handlerLogIn(code: String) {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        
        let credential = PhoneAuthProvider.provider().credential(
        withVerificationID: verificationID ?? " ", // verificationID ??
        verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
                if let view = self.view {
                    view.errorLogin(error: error!)
                }
            } else {
                UserDefaults.standard.set(authResult?.user.uid, forKey: "uid")
                self.view?.successLogin()
            }
        }
    }
}



