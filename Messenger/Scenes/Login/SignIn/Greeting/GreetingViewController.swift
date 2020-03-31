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
    
    var handlerState: AuthStateDidChangeListenerHandle?
    var viewModel: GreetingViewModeling?
    var router: GreetingRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleButton(LogInButton)
        Utilities.styleButton(SignUpButton)
        setupDependencies()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        let fir: AuthFirebase = FirebaseService.firebaseService
//
//        fir.signInHandlerState = Auth.auth().addStateDidChangeListener { auth, user in
//            if user != nil {
//                print("hello")
//                self.router?.routeToLogin(withIdentifier: "messengerMy", sender: self)
//            }
//        }
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

extension GreetingViewController: GreetingDelegate {
    
}
