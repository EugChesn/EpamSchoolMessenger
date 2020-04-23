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
        getUserContacts()
    }
    
    private func getUserContacts(){
        let firebaseObserver: ContactsList = FirebaseService.firebaseService
        firebaseObserver.getUserContacts { [weak self] (contacts) in
            guard let strongSelf = self else {return}
            strongSelf.contactList = contacts.sorted(by: {$0.name?.lowercased() ?? "z" < $1.name?.lowercased() ?? "z"})
            //strongSelf.contactList = contacts
            strongSelf.view?.updateContactList()
        }
    }
}
