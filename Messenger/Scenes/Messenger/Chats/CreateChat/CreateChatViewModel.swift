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
    func handlerSearch(searchText: String)
}

class CreateChatViewModel: CreateChatViewModeling {
    weak var view: CreateChatDelegate?
    private var contactsList: [Contact] = []
    private var filteredContactList: [Contact] = []

    var contactsCount: Int {
        get {
            if view!.isFiltering {
                return filteredContactList.count
            } else {
                return contactsList.count
            }
        }
    }
    
    init(view: CreateChatDelegate) {
        self.view = view
        downloadContacts()
    }
    func contact(atIndex: Int) -> Contact {
        if view!.isFiltering {
            return filteredContactList[atIndex]
        } else {
            return contactsList[atIndex]
        }
    }
    
    private func downloadContacts() {
        let firebaseObserver:ContactsObserver = FirebaseService.firebaseService
        
        firebaseObserver.downloadContacts { [weak self] (contactsList) in
            guard let strongSelf = self else {return}
            
            strongSelf.contactsList = contactsList.sorted(by: {$0.name?.lowercased() ?? "z" < $1.name?.lowercased() ?? "z"})
            strongSelf.view?.updateContactsList()
        }
    }
    
    func handlerSearch(searchText: String) {
        let valueFilter = contactsList.filter {
            if let name = $0.name {
                if let _ = name.range(of: searchText, options: .caseInsensitive) {
                    return true
                } else {
                    return false
                }
            }
            return false
        }
        
        filteredContactList = valueFilter
        view?.updateSearch()
    }
}


