//
//  ChatsListTableViewCell.swift
//  Messenger
//
//  Created by Admin on 22.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit

class ChatsListTableViewCell: UITableViewCell {
    @IBOutlet weak var chatListLogoImage: UIImageView!
    @IBOutlet weak var chatNamelabel: UILabel!
    @IBOutlet weak var lastMessageText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ChatListUtilities.styleImageView(chatListLogoImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
