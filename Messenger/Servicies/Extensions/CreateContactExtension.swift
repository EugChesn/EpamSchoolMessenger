//
//  CreateContactExtension.swift
//  Messenger
//
//  Created by Admin on 18.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol CreateContact{
    func addNewContact(contact: Contact)
    func searchForContact(userEmail: String, responce: @escaping ()->(), fault: @escaping ()->())
}

extension FirebaseService: CreateContact{
    func addNewContact(contact: Contact){
        guard let uid = currentUser?.uid else {return}
        let userContactReference = referenceDataBase.child("users").child(uid).child("contacts").childByAutoId()
        if uid != contact.uid{
            userContactReference.updateChildValues(contact.asDictionaryForContactList())
        }
    }
    
    func searchForContact(userEmail: String, responce: @escaping ()->(), fault: @escaping ()->()){
        let rootRef = FirebaseService.firebaseService.referenceDataBase
        let email = userEmail
        var contact = Contact()
        rootRef.child("users").queryOrdered(byChild: "email").queryStarting(atValue: email).queryEnding(atValue: email + "\u{f8ff}").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists(){
                let sometest = 0
                let contact = SnapshotDecoder.decode(type: Contact.self, snapshot: snapshot.value)
                if var contact = contact{
                    contact.uid = snapshot.key
                   
                }
                responce()
            } else if !snapshot.exists(){
                fault()
            }
        }
    }
}
