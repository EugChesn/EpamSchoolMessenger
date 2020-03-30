//
//  CreateChatViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 30.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol CreateChatViewModeling {
    var contactsCount: Int {get}
    
    func contact(atIndex: Int) -> Contact
}

class CreateChatViewModel: CreateChatViewModeling {
    weak var view: CreateChatDelegate?
    
    private var contactsList: [Contact] = [] {
        didSet {
            view?.updateContactsList()
        }
    }
    
    var contactsCount: Int {
        get {
            return contactsList.count
        }
    }
    
    init(view: CreateChatDelegate) {
        self.view = view
        
        contactsList.append(Contact())
        contactsList.append(Contact())
    }
    
    func contact(atIndex: Int) -> Contact {
        return contactsList[atIndex]
    }
}

struct Contact {
    var name: String = "testName"
    var uid: String = "testuid"
    var profileImage: UIImage?
}
