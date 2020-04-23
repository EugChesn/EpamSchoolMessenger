//
//  ContactsExtension.swift
//  Messenger
//
//  Created by Maxim on 16.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import Firebase

protocol ContactsList{
    func getUserContacts(completion: @escaping ([Contact]) -> ())
}

extension FirebaseService: ContactsList{
    func getUserContacts(completion: @escaping ([Contact]) -> ()){
        
        guard let uid = currentUser?.uid else {return}
    //Change to inividual UID
    // let userContactsReference = referenceDataBase.child("users").child(uid).child("contacts")
        let userContactsReference = referenceDataBase.child("users")
        userContactsReference.observeSingleEvent(of: .value) { (usersSnapshot) in
            var contactsList: [Contact] = []
            for user in usersSnapshot.children {
                let currentUser = user as! DataSnapshot
                let contact = SnapshotDecoder.decode(type: Contact.self, snapshot: currentUser.value)
                if var contact = contact {
                    contact.uid = currentUser.key
                    contactsList.append(contact)
                }
            }
            completion(contactsList)
        }
    }
}
