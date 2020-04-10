//
//  ContactsObserverExtension.swift
//  Messenger
//
//  Created by Евгений Гусев on 05.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol ContactsObserver {
    func downloadContacts(completion: @escaping ([Contact]) -> ())
}

extension FirebaseService: ContactsObserver {
    
    //Скачивает список всех юзеров в базе данных
    func downloadContacts(completion: @escaping ([Contact]) -> ()) {
        guard let uid = getCurrentUser()?.uid else {return}
        
        let userContactsReference = referenceDataBase
        var contactsList: [Contact] = []
    
        userContactsReference.observeSingleEvent(of: .value) { (snapshot) in
            let contacts = snapshot.childSnapshot(forPath: "users")
            if let dictionary = contacts.value as? [String: Any?] {
                
                for key in dictionary.keys {
                    let contact = SnapshotDecoder.decode(type: Contact.self, snapshot: dictionary[key] as Any?)
                    
                    if var contact = contact {
                        contact.uid = key
                        contactsList.append(contact)
                    }
                }
        
                completion(contactsList)
            }
        }
    }
}
