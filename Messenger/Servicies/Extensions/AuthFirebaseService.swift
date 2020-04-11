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

    func setProfileUser(name: String, nickName: String, photo: UIImage, completion: @escaping ()->())
    
    //разлогинить юзера
    func signOutUser()
    
    //Подписка на состояние юзера
    func listenStateUser(completion: @escaping (StateUser) -> ())
    func unListenStateUser()
    func resetWithPassword(email: String, fault: @escaping (Error)->())
    func checkMailExtistence(mail: String, responce: @escaping ()->(), fault: @escaping ()->(), errorWithFetch: @escaping (Error)->())
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
    
    func setProfileUser(name: String, nickName: String, photo: UIImage, completion: @escaping ()->()) {
        StorageService.shared.uploadImageProfile(img: photo) { [weak self] reference in
            reference.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("an error occured after uploading and then getting the URL")
                    return
                }
                self?.updateProfileInfo(name: name, nickName: nickName, photo: downloadURL)
                completion()
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
    
    func resetWithPassword(email: String, fault: @escaping (Error)->()){
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] (error) in
            guard let strongSelf = self else { return }
            if let err = error{
                fault(err)
            }
        }
    }
    
    func checkMailExtistence(mail: String, responce: @escaping ()->(), fault: @escaping ()->(), errorWithFetch: @escaping (Error)->()){
        Auth.auth().fetchSignInMethods(forEmail: mail) { [weak self] (respond, error) in
            guard let strongSelf = self else {return}
            if let err = error{
                print(err.localizedDescription)
                errorWithFetch(err)
            } else {
                if respond != nil{
                    responce()
                } else {
                    fault()
                }
            }
        }
    }
}
