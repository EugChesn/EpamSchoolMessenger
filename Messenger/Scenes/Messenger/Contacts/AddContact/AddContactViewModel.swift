//
//  AddContactViewModel.swift
//  Messenger
//
//  Created by Admin on 18.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

protocol AddContactViewModeling {
    func searchForUser(inputEmail: String)
}

class AddContactViewModel: AddContactViewModeling {
    weak var view: AddContactDelegate?
    var authfirebase: CreateContact?
    init(view: AddContactDelegate) {
        self.view = view
    }
    
     private func addNewContact(contact: Contact){
        guard let uid = FirebaseService.firebaseService.currentUser?.uid else {return}
        //guard let uid = currentUser?.uid else {return}
        print(uid)
        let userContactReference = FirebaseService.firebaseService.referenceDataBase.child("users").child(uid).child("contacts")
           //let userContactReference = referenceDataBase.child("users").child(uid).child("contacts").child(uid)
//           if uid != contact.uid{
//               userContactReference.updateChildValues(contact.asDictionaryForContactList())
//           }
        userContactReference.updateChildValues(contact.asDictionaryForContactList())
       }
    
    func searchForUser(inputEmail: String){
        authfirebase?.searchForContact(userEmail: inputEmail, responce: {
            //self.view?.succeesAdd()
        }, fault: {
            self.view?.faultToAdd()
        })
    }

}
