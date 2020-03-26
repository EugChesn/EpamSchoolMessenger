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
    
    private enum Constant {
        static let exit = "Log Out"
    }
    
    var viewModel: ProfileViewModeling?
    var router: ProfileRoutering?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//MARK: Profile Image
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = 65
        
        LogOutButton.setTitle(Constant.exit, for: .normal)
        
        setupDependencies()
    }
    
    func setupDependencies() {
        viewModel = ProfileViewModel(view: self)
        router = ProfileRouter(viewController: self)
    }
}

extension ProfileViewController: ProfileDelegate {
    
}
