//
//  CodeConfirmationViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation

protocol CodeConfirmationViewModeling {
    
}

class CodeConfirmationViewModel: CodeConfirmationViewModeling {
    let netService: NetworkInteraction = NetworkService()
    let storage: StorageData = StorageService()
    let reachability: Reachability = NetworkReachability()
}
