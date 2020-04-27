//
//  ManagerActivityIndicator.swift
//  Messenger
//
//  Created by Евгений on 14.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class ManagerActivityIndicator {
    static func styleActivity(message: String, type: NVActivityIndicatorType) -> ActivityData {
        let activityData = ActivityData(size: nil, message: message, messageFont: nil, messageSpacing: nil, type: type, color: nil, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil)
        
        return activityData
    }
    static func startAnimating(activity: ActivityData) {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activity)
    }
    static func stopAnimating() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}

