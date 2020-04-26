//
//  GreetingViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

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
        
        LogInButton.styleButton()
        SignUpButton.styleButton()
        setupDependencies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
//
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        Auth.auth().removeStateDidChangeListener(handlerState!)
//        TEST_FUNC_SIGN_OUT()
//    }
//    private func TEST_FUNC_SIGN_OUT(){
//        let firebaseAuth = Auth.auth()
//        do {
//          try firebaseAuth.signOut()
//        } catch let signOutError as NSError {
//          print ("Error signing out: %@", signOutError)
//        }
//    }
    
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

extension GreetingViewController: StoryboardInstantiatable {
    static let storyboardId = "LoginFlow"
    static let nameStoryboard = "Main"
    
    static var instantiateType: StoryboardInstantiateType {
        return .identifier(storyboardId)
    }
    static var storyboardName: String {
        return nameStoryboard
    }
}

extension GreetingViewController: GreetingDelegate {
    
}
