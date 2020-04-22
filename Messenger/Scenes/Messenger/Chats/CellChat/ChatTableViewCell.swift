//
//  ChatTableViewCell.swift
//  Messenger
//
//  Created by Евгений on 07.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameChat: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var timeMessage: UILabel!
    @IBOutlet weak var statusOnlineImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photo.layer.cornerRadius = photo.frame.size.height / 2
        photo.contentMode = .scaleAspectFill
        photo.layer.masksToBounds = true
        
        statusOnlineImage.layer.cornerRadius = statusOnlineImage.frame.size.height / 2
        statusOnlineImage.contentMode = .scaleAspectFill
        statusOnlineImage.layer.masksToBounds = true
    }

    override func prepareForReuse() { // MARK Important change!
        super.prepareForReuse()
        self.photo.sd_cancelCurrentImageLoad()
        self.photo?.image = nil
        statusOnlineImage.image = nil
    }
}
