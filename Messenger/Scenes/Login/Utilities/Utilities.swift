//
//  Utilities.swift
//  Messenger
//
//  Created by Евгений on 18.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class Utilities {
    static let maxLenPassword: Int = 16
    static let maxLenEmail: Int = 32
    static let maxLenText = 20
    
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
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    /*static func styleTextFieldRadius(_ textfield: UITextField) {
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = textfield.frame.height / 2
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.black.cgColor
    }*/
}
