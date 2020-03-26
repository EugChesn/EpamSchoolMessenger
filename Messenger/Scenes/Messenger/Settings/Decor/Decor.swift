//
//  Decor.swift
//  Messenger
//
//  Created by Анастасия Демидова on 26.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

class Decor {
    static func searchBar(_ searchController: UISearchController, placeholder: String) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = placeholder
    }
    
    static func styleCell(_ cell: UITableViewCell) {
        cell.accessoryType = .disclosureIndicator
    }
    
    static func styleImageView(_ imageView: UIImageView) {
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width/2
    }
    
    static func styleTextField(_ textField: UITextField, placeholder: String) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor .systemBlue.cgColor
        textField.layer.addSublayer(bottomLine)
        textField.placeholder = placeholder
        textField.borderStyle = .none
    }
}
