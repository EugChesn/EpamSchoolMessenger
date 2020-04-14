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
    static let maxLenText = 45
    
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
}
