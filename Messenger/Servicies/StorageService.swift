//
//  StorageService.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseAuth

protocol uploadProfilePhoto {
    func uploadImageProfile(img :UIImage, completion: @escaping () -> ())
}

class StorageService {
    static var shared: StorageService {
        let instance = StorageService()
        return instance
    }
    private(set) var storageRef: StorageReference
    
    private init() {
        storageRef = Storage.storage().reference()
    }
}

extension StorageService: uploadProfilePhoto {
    func uploadImageProfile(img: UIImage, completion: @escaping () -> ()) {
        guard let imageData: Data = img.jpegData(compressionQuality: 0.1) else {
            return
        }
        let user = FirebaseService.firebaseService.getCurrentUser()!
        let filePath = "\(user.uid)"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        self.storageRef.child(filePath).putData(imageData, metadata: metaData) { (metadata, error) in
            guard let _ = metadata else {
                print("error while uploading")
                return
            }
            self.storageRef.child(filePath).downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("an error occured after uploading and then getting the URL")
                    return
                }
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.photoURL = downloadURL
                changeRequest?.commitChanges { (error) in
                    if let err = error{
                        print(err.localizedDescription)
                    } else {
                        completion()
                    }
                }
                
            }
        }
        
    }
    
}
