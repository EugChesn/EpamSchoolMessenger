//
//  ProfileTableViewCell.swift
//  Messenger
//
//  Created by Анастасия Демидова on 01.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if profileImage != nil {
            Decor.styleImageView(profileImage)
            if let name = UserSettings.getObject(for: ProfileSetting.name),
                let email = UserSettings.getObject(for: ProfileSetting.email) {
                nameLabel.text = name as? String
                emailLabel.text = email as? String
            }
        }
    }
}
