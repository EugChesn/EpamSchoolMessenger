//
//  ChatListUtilities.swift
//  Messenger
//
//  Created by Admin on 22.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

class ChatListUtilities{

    static func styleImageView(_ imageView: UIImageView){
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
    }
}
