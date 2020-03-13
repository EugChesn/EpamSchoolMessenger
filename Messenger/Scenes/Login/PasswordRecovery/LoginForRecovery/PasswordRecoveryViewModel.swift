//
//  PasswordRecoveryViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol PasswordRecoveryViewModeling {
    
}

class PasswordRecoveryViewModel: PasswordRecoveryViewModeling {
    let netService: NetworkInteraction = NetworkService()
    let storage: StorageData = StorageService()
    let reachability: Reachability = NetworkReachability()
}