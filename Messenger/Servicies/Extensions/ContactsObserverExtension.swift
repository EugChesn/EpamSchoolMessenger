//
//  ContactsObserverExtension.swift
//  Messenger
//
//  Created by Евгений Гусев on 05.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import Firebase

protocol ContactsObserver {
    func downloadContacts(completion: @escaping ([Contact]) -> ())
}

extension FirebaseService: ContactsObserver {
    
    //Скачивает список всех юзеров в базе данных
    func downloadContacts(completion: @escaping ([Contact]) -> ()) {
        guard let uid = currentUser?.uid else {return}
        
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
