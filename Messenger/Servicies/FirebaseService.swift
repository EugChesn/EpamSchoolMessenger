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
    // дописать данные в бд полученные из профиля
    func writeNewDataProfile(update: [String:String], user: User) {
        /*let update = ["name": name,
                      "nickname": nickName]*/
        referenceDataBase.child("users").child(user.uid).updateChildValues(update)
    }
    
    func createUser(username: String, password: String, fault: @escaping (String?)->()) { // зарегистрировать нового пользователя
        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
            if let err = error {
                print(err.localizedDescription)
                fault(err.localizedDescription)
            } else {
                fault(nil)
                if let result = authResult {
                    self.writeNewUser(user: result.user)
                }
            }
        }
    }
    func getCurrentUser() -> User? { //получить текущего залогиненого пользователя
        return Auth.auth().currentUser
    }
    func setNameUser(name: String, nickName: String, completion: @escaping ()->()) {
        let currUser = getCurrentUser()
        let changeRequest = currUser!.createProfileChangeRequest()
        changeRequest.displayName = name
        //changeRequest?.photoURL = // add later
        changeRequest.commitChanges { (error) in
            if let err = error{
                print(err.localizedDescription)
            } else {
                let update = ["name": name,"nickname": nickName]
                self.writeNewDataProfile(update: update, user: currUser!)
                completion()
            }
        }
    }
    
    func signInUser(email: String,
                    password: String,
                    completion: @escaping ()->(),
                    faulture: @escaping (Error)->()){ // произвести логин юзера
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
        guard let strongSelf = self else { return }
            if let err = error {
                print(err.localizedDescription)
                faulture(err)
            } else {
                completion()
            }
        }
    }
}

