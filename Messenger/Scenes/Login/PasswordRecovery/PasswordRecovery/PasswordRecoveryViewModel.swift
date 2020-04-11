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
}

class PasswordRecoveryViewModel: PasswordRecoveryViewModeling {
    weak var view: PasswordRecoveryDelegate?
    weak var authFirebase: AuthFirebase?
    
    func resetPassword(email: String){
        authFirebase?.checkMailExtistence(mail: email, responce: {
            self.authFirebase?.resetWithPassword(email: email, fault: { (err) in
            self.view?.faultToResetPassword(error: err)
        })
            self.view?.resetSuccess()
        }, fault: {
            self.view?.noSuchEmail()
        }, errorWithFetch: { (err) in
            self.view?.faultToResetPassword(error: err)
        })
    }
    
    init(view: PasswordRecoveryDelegate) {
        self.view = view
        self.authFirebase = FirebaseService.firebaseService
    }
}

