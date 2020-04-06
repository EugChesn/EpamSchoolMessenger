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
        
        userContactsReference.observeSingleEvent(of: .value) { (snapshot) in
            let contacts = snapshot.childSnapshot(forPath: "users")
            if let dictionary = contacts.value as? [String: Any?] {
                var contactsList: [Contact] = []
                
                for key in dictionary.keys {
                    guard let contactInfo = dictionary[key] as? [String: String] else {return}
                    
                    var contact = Contact()
                    contact.uid = key
                    contact.name = contactInfo["name"] ?? ""
                    contact.nickname = contactInfo["nickname"] ?? ""
                    
                    contactsList.append(contact)
                }
                
                 completion(contactsList)
            }
        }
    }
}
