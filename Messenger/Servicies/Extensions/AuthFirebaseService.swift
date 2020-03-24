//
//  ExtensionFirebaseService.swift
//  Messenger
//
//  Created by Евгений on 24.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol AuthFirebase: class {
    // произвести логин юзера
    func signInUser(email: String,
                    password: String,
                    completion: @escaping ()->(),
                    faulture: @escaping (Error)->())
    
    // зарегистрировать нового пользователя
    func createUser(username: String,
                    password: String,
                    completion: @escaping ()->(),
                    fault: @escaping (Error)->())
    
    func setNameUser(name: String, nickName: String, photo: UIImage, completion: @escaping ()->())
}

extension FirebaseService: AuthFirebase {
    func signInUser(email: String,
                    password: String,
                    completion: @escaping ()->(),
                    faulture: @escaping (Error)->()){
        
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
    
    func createUser(username: String,
                    password: String,
                    completion: @escaping ()->(),
                    fault: @escaping (Error)->()) {
        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
            if let err = error {
                print(err.localizedDescription)
                fault(err)
            } else {
                if let result = authResult {
                    self.writeNewUser(user: result.user)
                    completion()
                }
            }
        }
    }
    
    func setNameUser(name: String, nickName: String, photo: UIImage, completion: @escaping ()->()) {
        StorageService.shared.uploadImageProfile(img: photo) {
            let currUser = self.getCurrentUser()
            let changeRequest = currUser!.createProfileChangeRequest()
            changeRequest.displayName = name
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
    }

}
