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

protocol ProfilePhoto {
    func uploadImageProfile(img :UIImage, completion: @escaping (StorageReference) -> ())
    func downloadImage(ref: StorageReference, completion: @escaping (UIImage) -> ())
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
    func getReference(url: String) -> StorageReference {
        return Storage.storage().reference(forURL: url)
    }
}

extension StorageService: ProfilePhoto {
    func uploadImageProfile(img: UIImage, completion: @escaping (StorageReference) -> ()) {
        guard let imageData: Data = img.jpegData(compressionQuality: 0.1) else {
            return
        }
        let user = FirebaseService.firebaseService.getCurrentUser()!
        let filePath = "\(user.uid)"
        let reference = self.storageRef.child("ProfileImage").child(filePath)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"

        reference.putData(imageData, metadata: metaData) { (metadata, error) in
            guard let _ = metadata else {
                print("error while uploading")
                return
            }
            completion(reference)
        }
    }
    
    func downloadImage(ref: StorageReference, completion: @escaping (UIImage) -> ()) {
        ref.getData(maxSize: 1000000) { (data, error) in
            if error != nil {
                print("Could not load image")
            } else {
                if let imgData = data {
                    if let img = UIImage(data: imgData) {
                        completion(img)
                    }
                }
            }
        }
    }
}
