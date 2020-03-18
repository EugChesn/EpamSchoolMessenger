//
//  SetupProfileViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol SetupProfileDelegate: class {
    func profileSucces()
}

class SetupProfileViewController: UIViewController {
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var goChatsButton: UIButton!
    
    var viewModel: SetupProfileViewModeling?
    var router: SetupProfileRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleTextField(nameTextFiled)
        Utilities.styleTextField(nicknameTextField)
        Utilities.styleButton(goChatsButton)
        setupDependencies()
    }
    
    @IBAction func goToChatsTap(_ sender: UIButton) {
        guard let name = nameTextFiled.text else {return}
        guard let nick = nicknameTextField.text else {return}
        viewModel?.setupProfileUser(name: name, nickname: nick)
    }
    
    func setupDependencies() {
        viewModel = SetupProfileViewModel(view: self)
        router = SetupProfileRouter(viewController: self)
    }
}

extension SetupProfileViewController: SetupProfileDelegate {
    func profileSucces() {
        router?.routeToChat(withIdentifier: "profileToMessanger", sender: self)
    }
}
