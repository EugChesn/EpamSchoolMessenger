//
//  ClassNameExtension.swift
//  Messenger
//
//  Created by Евгений on 08.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
