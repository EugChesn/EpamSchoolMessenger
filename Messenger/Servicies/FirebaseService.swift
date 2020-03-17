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
    private func writeNewUser(user:  User) { // добавить нового юзера в бд
        referenceDataBase.child("users").child(user.uid).setValue(["email": user.email])
    }
    
    func createUser(username: String, password: String) { // зарегистрировать нового пользователя
        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
            if let err = error {
                print(err.localizedDescription)
            } else {
                if let result = authResult {
                    self.writeNewUser(user: result.user)
                }
            }
        }
    }
    func getCurrentUser() -> User? { //получить текущего залогиненого пользователя
        return Auth.auth().currentUser
    }
    func signInUser(email: String,
                    password: String,
                    completion: @escaping ()->(),
                    faulture: @escaping ()->()){ // произвести логин юзера
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
        guard let strongSelf = self else { return }
            if let err = error {
                faulture()
            } else {
                completion()
            }
        }
    }
}

