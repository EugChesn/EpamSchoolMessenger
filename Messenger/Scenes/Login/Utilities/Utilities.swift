//
//  Utilities.swift
//  Messenger
//
//  Created by Евгений on 18.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    static func styleTextField(_ textfield: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor .systemBlue.cgColor
        
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
    }
    static func styleButton(_ button: UIButton) {
        button.backgroundColor = UIColor .systemBlue
        button.layer.cornerRadius = 16
    }
    static func styleImageView(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
    }
    static func validatePass(password: String) -> Bool
    {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: password)
    }
}
