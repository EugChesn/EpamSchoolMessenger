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
    var handlerState: AuthStateDidChangeListenerHandle?
    private var firebasObservers: [String: UInt] = [:]
    
    static let firebaseService = FirebaseService()
    private init(){
        referenceDataBase = Database.database().reference() // ссылка на бд
        referenceUser = referenceDataBase.child("users")
    }
    func getCurrentUser() -> User? { //получить текущего залогиненого пользователя
        return Auth.auth().currentUser
    }
    // обновить данные в бд
    func writeNewDataCurrUser(update: [String:String], completion: @escaping (Error?)->()) {
        if let uid = Auth.auth().currentUser?.uid {
            referenceUser.child(uid).updateChildValues(update) { err, _ in
                completion(err)
            }
        }
    }

    func updateProfileInfo(email: String, name: String, nickName: String, photo: URL, completion: @escaping (Error?)->()) {
        let currUser = self.getCurrentUser()
        let changeRequest = currUser!.createProfileChangeRequest()
        changeRequest.displayName = name
        changeRequest.photoURL = photo
        changeRequest.commitChanges { (error) in
            if let err = error{
                print(err.localizedDescription)
            } else {
                let update = ["email": email, "name": name,"nickname": nickName,"photoUrl": photo.absoluteString]
                self.writeNewDataCurrUser(update: update) { err in
                    completion(err)
                }
            }
        }
    }
    
    func removeObserver(observer: String) {
        guard let observerId = firebasObservers[observer] else {return}
        referenceDataBase.removeObserver(withHandle: observerId)
        firebasObservers.removeValue(forKey: observer)
    }
    
    func addObserverId(observer: String, id: UInt) {
        firebasObservers[observer] = id
    }
}

