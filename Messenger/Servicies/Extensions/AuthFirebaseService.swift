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
    
    // единая процедура регистрации пользователя
    func registerUser(name: String,
                      nickName: String,
                      email: String,
                      password: String,
                      photo: UIImage?, completion: @escaping (_ error: Error?)->())
    
    // зарегистрировать нового пользователя (в базе данных сущности юзера не появляется)
    func createUser(email: String,
                    password: String,
                    completion: @escaping (Error?)->())

    // запись данных юзера в базу данных и в storage
    func setProfileUser(email: String,
                        name: String,
                        nickName: String,
                        photo: UIImage?, completion: @escaping (Error?)->())
    
    
    //разлогинить юзера
    func signOutUser()
    
    //удалить аккаунт текущего юзера
    func deleteCurrUser()
    
    //Подписка на состояние юзера
    func listenStateUser(completion: @escaping (StateUser) -> ())
    func unListenStateUser()
}

extension FirebaseService: AuthFirebase {
    
    func listenStateUser(completion: @escaping (StateUser) -> ()) {
        handlerState = Auth.auth().addStateDidChangeListener { (_ , user) in
            user != nil ? completion(StateUser.Authorised) : completion(StateUser.NotAuthorised)
        }
    }
    
    func unListenStateUser() {
        Auth.auth().removeStateDidChangeListener(handlerState!)
    }
    
    func signInUser(email: String,
                    password: String,
                    completion: @escaping ()->(),
                    faulture: @escaping (Error)->()){
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let err = error {
                print(err.localizedDescription)
                faulture(err)
            } else {
                completion()
            }
        }
    }
    
    func createUser(email: String,
                    password: String,
                    completion: @escaping (Error?)->()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error {
                print(err.localizedDescription)
                completion(err)
            } else {
                if let _ = authResult {
                    completion(nil)
                }
            }
        }
    }
    
    func setProfileUser(email: String, name: String, nickName: String, photo: UIImage?, completion: @escaping (Error?)->()) {
        if let photo = photo {
            StorageService.shared.uploadImageProfile(img: photo) { [weak self] reference in
                reference.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("an error occured after uploading and then getting the URL")
                        return
                    }
                    
                    self?.updateProfileInfo(email: email, name: name, nickName: nickName, photo: downloadURL) { err in
                        if let err = err {
                            completion(err)
                        } else {
                            completion(nil)
                        }
                    }
                }
            }
        }
        
        let update = ["email": email, "name": name, "nickname": nickName]
        self.writeNewDataCurrUser(update: update) { errWriteData in
            if let errWriteData = errWriteData {
                completion(errWriteData)
            } else {
                completion(nil)
            }
        }
    }
    
    func registerUser(name: String, nickName: String, email: String, password: String, photo: UIImage?,
                      completion: @escaping (_ error: Error?)->()) {
        
        createUser(email: email,
                   password: password,
                   completion: { errCreate in
                        if let errCreate = errCreate {
                            completion(errCreate)
                        } else {
                            self.setProfileUser(email: email, name: name, nickName: nickName, photo: photo, completion: { errProfile in
                                    completion(errProfile)
                                 })
                        }
                    })
    }
    
    func deleteCurrUser() {
        let user = Auth.auth().currentUser
        user?.delete { error in
          if let _ = error {
            // An error happened.
          } else {
            // Account deleted.
          }
        }
    }
    
    func signOutUser() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
