//
//  MessangerModels.swift
//  Messenger
//
//  Created by Евгений Гусев on 31.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

struct Contact: Codable {
    var email: String?
    var name: String?
    var nickname: String?
    var uid: String?
    var profileImageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case name = "name"
        case nickname = "nickname"
        case uid = "uid"
        case profileImageUrl = "photoUrl"
    }
}

struct MessageModel: Codable {
    var from: String!
    var to: String!
    var text: String!
    var timeSpan: String!
    
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

struct ChatInfo: Codable {
    var lastMessage: String?
    var timeSpan: String?
    var contact: Contact!
}

enum StateUser {
    case Authorised
    case NotAuthorised
}

struct ContactList: Codable {
    var users: [String:[Contact]]
}
