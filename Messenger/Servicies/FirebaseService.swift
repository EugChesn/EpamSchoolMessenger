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
    private(set) var referenceUser: DatabaseReference
    
    static let firebaseService = FirebaseService()
    private init(){
        referenceDataBase = Database.database().reference() // ссылка на бд
        referenceUser = referenceDataBase.child("users")
    }
    func getCurrentUser() -> User? { //получить текущего залогиненого пользователя
        return Auth.auth().currentUser
    }
    // обновить данные в бд
    func writeNewDataProfile(update: [String:String], user: User) {
        referenceUser.child(user.uid).updateChildValues(update)
    }
    
    func writeNewUser(user:  User) { // добавить нового юзера в бд
        referenceUser.child(user.uid).setValue(["email": user.email])
    }

    func updateProfileInfo(name: String, nickName: String, photo: URL) {
        let currUser = self.getCurrentUser()
        let changeRequest = currUser!.createProfileChangeRequest()
        changeRequest.displayName = name
        changeRequest.photoURL = photo
        changeRequest.commitChanges { (error) in
            if let err = error{
                print(err.localizedDescription)
            } else {
                let update = ["name": name,"nickname": nickName]
                self.writeNewDataProfile(update: update, user: currUser!)
            }
        }
    }
}
