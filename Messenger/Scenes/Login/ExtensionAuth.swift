//
//  ExtensionAuth.swift
//  Messenger
//
//  Created by Евгений on 18.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import FirebaseAuth

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
            return "Your password is too weak \n Minimum 8 characters at least 1 uppercase alphabet, 1 lowercase alphabet, 1 Number and 1 special character:"
        default:
            return "Unknown error occurred"
        }
    }
}

extension UIViewController {
    func alertError(errorCode: AuthErrorCode) {
        let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
public extension UIView {
    func shake(count : Float = 4,
               for duration : TimeInterval = 0.5,
               withTranslation translation : Float = 5) {
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}

extension String {
    func isValidateEmail() -> Bool {
        let emailFormat = "^[A-Z0-9a-z][a-zA-Z0-9_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    func isValidatePass() -> Bool
    {
        //let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let regularExpression = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~']{8,}$"
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: self)
    }
}
