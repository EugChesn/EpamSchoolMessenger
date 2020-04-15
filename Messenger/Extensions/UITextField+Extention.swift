//
//  UITextField+Extention.swift
//  Messenger
//
//  Created by Анастасия Демидова on 15.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

extension UITextField {
    func styleTextField(placeholder: String) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor .systemBlue.cgColor
        self.layer.addSublayer(bottomLine)
        self.placeholder = placeholder
        self.borderStyle = .none
    }
}
