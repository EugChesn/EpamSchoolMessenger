//
//  ChatsViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ChatsViewModeling {
    
}

class ChatsViewModel: ChatsViewModeling {
    weak var view: ChatsDelegate?
    
    init(view: ChatsDelegate) {
        self.view = view
    }
}
