//
//  SignUpViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol SignUpViewModeling {
    
}

class SignUpViewModel: SignUpViewModeling {
    let netService: NetworkInteraction = NetworkService()
    let storage: StorageData = StorageService()
    let reachability: Reachability = NetworkReachability()
}
