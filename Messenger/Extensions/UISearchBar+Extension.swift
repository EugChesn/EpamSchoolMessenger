//
//  UISearchBar+Extension.swift
//  Messenger
//
//  Created by Анастасия Демидова on 25.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

extension UISearchBar {
    func setTextColor(color: UIColor = .white) {
        UITextField.appearance(whenContainedInInstancesOf:
             [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }
}
