//
//  UISearchController+Extention.swift
//  Messenger
//
//  Created by Анастасия Демидова on 15.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

extension UISearchController {
    func searchBarStyle(placeholder: String) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = placeholder
    }
}
