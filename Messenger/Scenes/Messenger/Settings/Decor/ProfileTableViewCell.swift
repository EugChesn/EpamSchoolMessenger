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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if profileImage != nil {
            Decor.styleImageView(profileImage)
        }
    }
}
