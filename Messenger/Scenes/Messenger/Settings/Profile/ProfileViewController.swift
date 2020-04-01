//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Анастасия Демидова on 25.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileDelegate: class {
    
}

class ProfileViewController: UITableViewController {
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var LogOutButton: UIButton!
    @IBOutlet private weak var EditPhotoButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var nickNameTextField: UITextField!
    @IBOutlet private weak var birthdayTextField: UITextField!
    
    var viewModel: ProfileViewModeling?
    var router: ProfileRoutering?
    
    private enum Constant {
        static let edit = "Edit Profile"
        static let doneButton = "Done"
        static let exit = "Log Out"
        static let name = "Name"
        static let nickName = "Nickname"
        static let birthday = "Birthday"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationItem()
        LogOutButton.setTitle(Constant.exit, for: .normal)
//MARK: Profile Image
        Decor.styleImageView(profileImage)
//MARK: TextField
        Decor.styleTextField(nameTextField, placeholder: Constant.name)
        Decor.styleTextField(nickNameTextField, placeholder: Constant.nickName)
        Decor.styleTextField(birthdayTextField, placeholder: Constant.birthday)

        setupDependencies()
    }
    
    private func setupDependencies() {
        viewModel = ProfileViewModel(view: self)
        router = ProfileRouter(viewController: self)
    }
    
    private func settingNavigationItem() {
        navigationItem.title = Constant.edit
        navigationItem.rightBarButtonItem?.title = Constant.doneButton
    }
}

extension ProfileViewController: ProfileDelegate {
    
}
