//
//  MessangerModels.swift
//  Messenger
//
//  Created by Евгений Гусев on 31.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

struct Contact {
    var name: String = "testName"
    var uid: String = "testuid"
    var profileImage: UIImage?
}

struct MessageModel {
    var from: String = "testFrom"
    var to: String = "testTo"
    var text: String = "testText"
    var timeSpan: String = "testTime"
}

struct ChatInfo {
    var lastMessage: String = "test"
    var contact: Contact
}
