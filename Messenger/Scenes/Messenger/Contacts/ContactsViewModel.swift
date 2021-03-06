//
//  ContactsViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ContactsViewModeling {
    
}

class ContactsViewModel: ContactsViewModeling {
    weak var view: ContactsDelegate?
    
    init(view: ContactsDelegate) {
        self.view = view
    }
}
