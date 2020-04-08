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
    
    //func getImageContact(uid: String) -> UIImage?
}

class CreateChatViewModel: CreateChatViewModeling {
    weak var view: CreateChatDelegate?
    private var contactsList: [Contact] = []
    
    /*private var imageContacts: [String: UIImage] = [:] {
        didSet {
            view?.updateContactsList()
        }
    }
    func getImageContact(uid: String) -> UIImage? {
        return imageContacts[uid]
    }*/
    
    var contactsCount: Int {
        get {
            return contactsList.count
        }
    }
    
    init(view: CreateChatDelegate) {
        self.view = view
        
        downloadContacts()
    }
    func contact(atIndex: Int) -> Contact {
        return contactsList[atIndex]
    }
    
    private func downloadContacts() {
        let fir:ContactsObserver = FirebaseService.firebaseService
        
        fir.downloadContacts { [weak self] (contactsList) in
            guard let strongSelf = self else {return}
            
            var tmpList = contactsList
            tmpList.sort{ (contact1,contact2) -> Bool in
                if contact1.name > contact2.name {
                    return true
                } else {
                    return false
                }
            }
            strongSelf.contactsList = tmpList
            
            /*contactsList.forEach { contact in
                strongSelf.downloadImageUrl(contact: contact)
            }*/
            
            strongSelf.view?.updateContactsList()
        }
    }
    
    /*private func downloadImageUrl(contact: Contact) {
        if let urlPhoto = contact.profileImageUrl {
            let reference = StorageService.shared.getReference(url: urlPhoto)
            StorageService.shared.downloadImage(ref: reference) { [weak self] image in
                guard let strongSelf = self else {return}
                strongSelf.imageContacts.updateValue(image, forKey: contact.uid)
            }
        }
    }*/
}


