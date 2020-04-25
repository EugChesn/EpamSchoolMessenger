//
//  ChatCell.swift
//  Messenger
//
//  Created by Евгений on 13.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameChat: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photo.roundWithoutBorder()
        shadowView.addShadow()
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() { // MARK Important change!
        super.prepareForReuse()
        self.photo.sd_cancelCurrentImageLoad()
        self.photo?.image = nil
    }
}
