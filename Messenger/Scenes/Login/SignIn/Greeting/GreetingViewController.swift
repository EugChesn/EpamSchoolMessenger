//
//  GreetingViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol GreetingDelegate: class {
    
}

class GreetingViewController: UIViewController {
    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    var viewModel: GreetingViewModeling?
    var router: GreetingRouting?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "signIn" else { return }
        guard let destination = segue.destination as? SignInViewController else { return }
        destination.backName = "Greeting"
    }
    
    @IBAction func LogInTap(_ sender: UIButton) {
        router?.routeToLogin(withIdentifier: "signIn", sender: self)
    }
    @IBAction func SignUpTap(_ sender: UIButton) {
        router?.routeToLogin(withIdentifier: "singUp", sender: self)
    }
    
    func setupDependencies() {
        viewModel = GreetingViewModel(view: self)
        router = GreetingRouter(viewController: self)
    }
}

extension GreetingViewController: GreetingDelegate {
    
}
