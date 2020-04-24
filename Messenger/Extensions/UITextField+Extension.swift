//
//  UITextField+Extension.swift
//  Messenger
//
//  Created by Анастасия Демидова on 15.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

extension UITextField {
    func styleTextField(placeholder: String, colorLine: String = "main") {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height - 2, width: frame.width, height: 2)
        bottomLine.backgroundColor = UIColor(named: colorLine)?.cgColor
        layer.addSublayer(bottomLine)
        self.placeholder = placeholder
        borderStyle = .none
    }
}
