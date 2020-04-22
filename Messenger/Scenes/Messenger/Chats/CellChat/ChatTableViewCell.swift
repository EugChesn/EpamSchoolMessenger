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
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photo.layer.cornerRadius = photo.frame.size.height / 2
        photo.contentMode = .scaleAspectFill
        photo.layer.masksToBounds = true
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowView.layer.shadowOpacity = 0.1
        shadowView.layer.cornerRadius = 8
    }

    override func prepareForReuse() { // MARK Important change!
        super.prepareForReuse()
        self.photo.sd_cancelCurrentImageLoad()
        self.photo?.image = nil
    }
}
