//
//  UserModel.swift
//  Messenger
//
//  Created by Анастасия Демидова on 12.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

struct ProfileSetting {
    static let name = "name"
    static let nickname = "nickname"
    static let email = "email"
   
    var name: String
    var nickname: String
    var email: String
    
    init(_ name: String?, _ nickname: String?, _ email: String?) {
        self.name = name ?? ""
        self.nickname = nickname ?? ""
        self.email = email ?? ""
    }
}
