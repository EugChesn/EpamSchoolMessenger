//
//  UIImageView+Extension.swift
//  Messenger
//
//  Created by Анастасия Демидова on 15.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

extension UIImageView {
    func roundWithBorder() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.cornerRadius = frame.size.width/2
    }
    func roundWithoutBorder() {
        layer.cornerRadius = frame.size.height / 2
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
    }
}
