//
//  UIButton+Extension.swift
//  Messenger
//
//  Created by Анастасия Демидова on 24.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

extension UIButton {
    func styleButton() {
        backgroundColor = UIColor(named: "3B8AC4")
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1.0
    }
}
