//
//  BaseViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

class BaseViewModel<T> where T: AnyObject {
    weak var view: T?
    
    init(view: T) {
        self.view = view
    }
}
