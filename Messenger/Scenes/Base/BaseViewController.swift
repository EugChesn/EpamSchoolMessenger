//
//  BaseViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController<V,R>: UIViewController {
    var viewModel: V?
    var router: R?
}
