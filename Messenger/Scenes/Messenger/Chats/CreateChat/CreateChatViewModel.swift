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
        let refDatabase = FirebaseService.firebaseService.referenceDataBase
        refDatabase.child("users").observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                var contact = Contact()
                
                contact.name = dictionary["name"] as? String ?? ""
                contact.uid = snapshot.key
                
                self.contactsList.append(contact)
            }
        }
        
    }
    
    func contact(atIndex: Int) -> Contact {
        return contactsList[atIndex]
    }
}


