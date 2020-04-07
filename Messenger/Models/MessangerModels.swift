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
    var nickname: String = "testNickName"
    var uid: String = "testuid"
    var profileImageUrl: String?
    
    init() {}
    init (name: String, nickname: String, uid: String, profileImage: String?) {
        self.name = name
        self.nickname = nickname
        self.uid = uid
        self.profileImageUrl = profileImage
    }
}

struct MessageModel {
    var from: String = ""
    var to: String = ""
    var text: String = ""
    var timeSpan: String = ""
    
    func asDictionary() -> [String: String] {
        return ["from": from, "to": to, "text": text, "timeSpan": timeSpan]
    }
    
    func asDictionaryForChatInfo() -> [String: String] {
        return ["lastMessage": text, "timeSpan": timeSpan]
    }
    
    mutating func fromDictionary(dictionary: [String: String]) {
        guard let from = dictionary["from"],
            let to = dictionary["to"],
            let text = dictionary["text"],
            let timeSpan = dictionary["timeSpan"]
            else {return}
        
        self.from = from
        self.to = to
        self.text = text
        self.timeSpan = timeSpan
    }
        
}

struct ChatInfo {
    var lastMessage: String = ""
    var timeSpan: String = ""
    var contact: Contact
}

enum StateUser {
    case Authorised
    case NotAuthorised
}
