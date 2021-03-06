//
//  ProfileViewModel.swift
//  Messenger
//
//  Created by Анастасия Демидова on 25.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileViewModeling {
    var contact: Contact { get }
    var birthday: String { get set }
    func updateDataProfile(update: [String: String])
    func updatePhoto(photo: UIImage, completion: @escaping (URL) -> ())
    func updateUserDefaults(_ name: String, _ nickname: String)
}

class ProfileViewModel: ProfileViewModeling {
    weak var view: ProfileDelegate?
    weak var base = FirebaseService.firebaseService
    
    private var data = Contact()
    var contact: Contact {
        get {
            return data
        }
    }
    
    var birthday: String {
        get {
            return UserSettings.getObject(for: ProfileSetting.birthday) as! String
        }
        set {
            UserSettings.save(object: newValue, for: ProfileSetting.birthday)
        }
    }
    
    init(view: ProfileDelegate) {
        self.view = view
        getDataProfile()
        updateUserDefaults(data.name ?? "", data.nickname ?? "")
    }
    
    private func getDataProfile()  {
        base?.getUserData() { [weak self] (user) in
            guard let self = self else { return }
            guard let current = user else { return }
            
            self.data = current
            self.view?.updateProfile(user: self.data)
        }
    }
    
    func updateDataProfile(update: [String: String]) {
        base?.writeNewDataCurrUser(update: update, id: nil) { errorWrite in
            if let errorWrite = errorWrite {
                print(errorWrite.localizedDescription)
            }
        }
    }
    
    func updatePhoto(photo: UIImage, completion: @escaping (URL) -> ()) {
        StorageService.shared.uploadImageProfile(img: photo) { reference in
            reference.downloadURL { (url, error) in
                if let newUrl = url {
                    self.base?.writeNewDataCurrUser(update: ["photoUrl": newUrl.absoluteString], id: nil) { error in
                        if let _ = error {
                            print("error change url")
                        }  else {
                            completion(newUrl)
                        }
                    }
                } else {
                    print("error upload new image")
                }
            }
        }
    }
    
    func updateUserDefaults(_ name: String, _ nickname: String) {
        UserSettings.save(object: name, for: ProfileSetting.name)
        UserSettings.save(object: nickname, for: ProfileSetting.nickname)
    }
}
