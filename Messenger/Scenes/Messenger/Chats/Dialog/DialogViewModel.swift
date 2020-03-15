//
//  DialogeViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 15.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol DialogViewModeling {
    
}

class DialogViewModel: DialogViewModeling {
    weak var view: DialogDelegate?
    
    init(view: DialogDelegate) {
        self.view = view
    }
}
