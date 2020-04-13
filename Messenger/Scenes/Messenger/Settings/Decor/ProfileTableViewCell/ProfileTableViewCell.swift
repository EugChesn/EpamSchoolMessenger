//
//  ProfileTableViewCell.swift
//  Messenger
//
//  Created by Анастасия Демидова on 01.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    let placeHolderImage = UIImage(named: "profile")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if profileImage != nil {
            Decor.styleImageView(profileImage)

//            FirebaseService.firebaseService.getUserData() { [weak self] (user) in
//                guard let current = user else { return }
//                let contactURL = current.profileImageUrl
//                if let urlPhoto = contactURL {
//                    let reference = StorageService.shared.getReference(url: urlPhoto)
//                    self?.profileImage.sd_setImage(with: reference, placeholderImage: self?.placeHolderImage)
//                }
//            }
        }
    }
}
