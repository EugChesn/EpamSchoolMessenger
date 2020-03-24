//
//  FirebaseService.swift
//  Messenger
//
//  Created by Евгений on 16.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    private(set) var referenceDataBase: DatabaseReference
    
    static let firebaseService = FirebaseService()
    private init(){
        referenceDataBase = Database.database().reference() // ссылка на бд
    }
    func getCurrentUser() -> User? { //получить текущего залогиненого пользователя
        return Auth.auth().currentUser
    }
    // дописать данные в бд полученные из профиля
    func writeNewDataProfile(update: [String:String], user: User) {
        referenceDataBase.child("users").child(user.uid).updateChildValues(update)
    }
    
    func writeNewUser(user:  User) { // добавить нового юзера в бд
        referenceDataBase.child("users").child(user.uid).setValue(["email": user.email])
    }
}

