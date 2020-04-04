//
//  ContactsViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ContactsViewModeling {
    var contactCount: Int {get}
    func getContact(index: Int) -> Contact
}

class ContactsViewModel: ContactsViewModeling {
    
    weak var view: ContactsDelegate?
    weak var authService: AuthFirebase?
    
    private var contactList: [Contact] = [] {
        didSet {
            view?.updateContactList()
        }
    }
    
    func getContact(index: Int) -> Contact{
        return contactList[index]
    }
    
    var contactCount: Int {
        get {
            return contactList.count
        }
    }
    
    init(view: ContactsDelegate) {
        self.view = view
        let dataReference = FirebaseService.firebaseService.referenceDataBase
        if let currentuser = FirebaseService.firebaseService.getCurrentUser()?.uid {
            dataReference.child("users").observe(.childAdded) { (snapshot) in
                //let uid = snapshot.key
                if let dictionary = snapshot.value as? [String: String] {
                    var contact = Contact()
                    contact.name = dictionary["name"] ?? ""
                    contact.uid = currentuser
                    self.contactList.append(contact)
                }
            }
        }
    }
}
