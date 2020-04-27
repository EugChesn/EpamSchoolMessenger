//
//  TimerFirebaseExtensions.swift
//  Messenger
//
//  Created by Евгений on 21.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol OnlineStatus: class {
    func writeTimeOnlineCurrUser(status: StatusUser, completion: @escaping (Result<String, Error>) -> ())
    func checkTime(uid: String, completion: @escaping (Result<String, Error>) -> ())
}

extension FirebaseService: OnlineStatus {
    func writeTimeOnlineCurrUser(status: StatusUser, completion: @escaping (Result<String, Error>) -> ()) {
        
        let currTime = Date().currentTime
        let update =  ["time": currTime, "status": status.rawValue]
        FirebaseService.firebaseService.writeNewDataCurrUser(update: update, id: nil) { errorWrite in
            if let err = errorWrite {
                completion(.failure(err))
            }
            completion(.success(currTime))
        }
    }
    
    func checkTime(uid: String, completion: @escaping (Result<String, Error>) -> ()) {
        let userReference = referenceDataBase.child("users").child(uid)
        
        userReference.observeSingleEvent(of: .value, with: { snapshot in
            if let user = SnapshotDecoder.decode(type: Contact.self, snapshot: snapshot.value) {
                if let newTime = user.time {
                    completion(.success(newTime))
                } else {
                    print("error users no time")
                }
            } else {
                print("error decode observe users")
            }
        }) { error in
            completion(.failure(error))
        }
    }
}
