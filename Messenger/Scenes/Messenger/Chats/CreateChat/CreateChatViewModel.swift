//
//  CreateChatViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 30.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol CreateChatViewModeling {
    
}

class CreateChatViewModel: CreateChatViewModeling {
    weak var view: CreateChatDelegate?
    
    init(view: CreateChatDelegate) {
        self.view = view
    }
}
