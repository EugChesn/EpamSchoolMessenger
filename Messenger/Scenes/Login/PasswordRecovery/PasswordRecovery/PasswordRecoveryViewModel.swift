//
//  PasswordRecoveryViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol PasswordRecoveryViewModeling {
    func resetPassword(email: String)
    func isValidEmail(_ email: String) -> Bool
}

class PasswordRecoveryViewModel: PasswordRecoveryViewModeling {
    weak var view: PasswordRecoveryDelegate?
    
    func resetPassword(email: String){
        FirebaseService.firebaseService.resetWithPassword(email: email) { (err) in
            self.view?.faultToResetPassword(error: err)
        }
        view?.resetSuccess()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    init(view: PasswordRecoveryDelegate) {
        self.view = view
    }
}

