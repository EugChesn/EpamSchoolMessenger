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
    
    var currentUser: User? { //получить текущего залогиненого пользователя
        return Auth.auth().currentUser
    }
    // обновить данные в бд
    func writeNewDataCurrUser(update: [String:String], id: String?, completion: @escaping (Error?)->()) {
        if let uid = id {
            referenceUser.child(uid).updateChildValues(update) { err, _ in
                completion(err)
            }
        } else {
            if let uid = Auth.auth().currentUser?.uid {
                referenceUser.child(uid).updateChildValues(update) { err, _ in
                    completion(err)
                }
            } else {
                print("current user is not define")
            }
        }
    }
    
    func updateProfileInfo(email: String, name: String, nickName: String, photo: URL, completion: @escaping (Error?)->()) {
        let currUser = currentUser
        let changeRequest = currUser!.createProfileChangeRequest()
        changeRequest.displayName = name
        changeRequest.photoURL = photo
        changeRequest.commitChanges { (error) in
            if let err = error{
                print(err.localizedDescription)
            } else {
                let update = ["email": email, "name": name,"nickname": nickName,"photoUrl": photo.absoluteString]
                self.writeNewDataCurrUser(update: update, id: nil) { err in
                    completion(err)
                }
            }
        }
    }
    
    func getUserData(completion: @escaping (Contact?) -> ()) {
        if let uid = currentUser?.uid {
            let referenseDB = referenceDataBase.child("users").child(uid)
            referenseDB.observe(.value) { (snapshot) in
                guard let user = SnapshotDecoder.decode(type: Contact.self, snapshot: snapshot.value) else { return }
                completion(user)
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
