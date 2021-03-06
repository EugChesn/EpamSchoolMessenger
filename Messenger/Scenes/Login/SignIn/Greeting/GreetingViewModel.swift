//
//  GreetingViewModel.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import Firebase

protocol GreetingViewModeling {
    
}

class GreetingViewModel: GreetingViewModeling {
    weak var view: GreetingDelegate?
    
    init(view: GreetingDelegate) {
        self.view = view
    }
}
