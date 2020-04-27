//
//  SnapshotDecoder.swift
//  Messenger
//
//  Created by Евгений Гусев on 10.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

class SnapshotDecoder {
    static func decode<T:Codable>(type: T.Type, snapshot: Any?) -> T? {
        guard let snapshot = snapshot as? [String: Any],
            let data = try? JSONSerialization.data(withJSONObject: snapshot as Any, options: []),
            let object = try? JSONDecoder().decode(type, from: data)
        else {
            return nil
        }
        
        return object
    }
}
