//
//  UIImageView+Extention.swift
//  Messenger
//
//  Created by Анастасия Демидова on 15.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

extension UIImageView {
    func roundWithBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.layer.cornerRadius = self.frame.size.width/2
    }
}
