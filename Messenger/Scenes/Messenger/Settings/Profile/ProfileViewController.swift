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
    func updateProfile(user:Contact)
}

class ProfileViewController: UITableViewController {
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var LogOutButton: UIButton!
    @IBOutlet private weak var EditPhotoButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var nickNameTextField: UITextField!
    @IBOutlet private weak var birthdayTextField: UITextField!
    
    let datePicker = UIDatePicker()
    let placeHolderImage = UIImage(named: "profile")
    
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
    
    @IBAction func doneButton(_ sender: Any) {
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let nickname = nickNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        let contactURL = viewModel?.contact().profileImageUrl
        if let urlPhoto = contactURL {
            let reference = StorageService.shared.getReference(url: urlPhoto)
            self.profileImage.sd_setImage(with: reference, placeholderImage: placeHolderImage)
            reference.downloadURL { (url, error) in
                
                if !name.isEmpty && !nickname.isEmpty {
                    self.viewModel?.updateDataProfile(name: name, nickname: nickname, photo: url!)
                }
            }
            router?.routeSettings()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationItem()
        nameTextField.delegate = self
        nickNameTextField.delegate = self
        LogOutButton.setTitle(Constant.exit, for: .normal)
        //MARK: Profile Image
        if profileImage != nil {
            Decor.styleImageView(profileImage)
            
            FirebaseService.firebaseService.getUserData() { [weak self] (user) in
                guard let current = user else { return }
                let contactURL = current.profileImageUrl
                if let urlPhoto = contactURL {
                    let reference = StorageService.shared.getReference(url: urlPhoto)
                    self?.profileImage.sd_setImage(with: reference, placeholderImage: self?.placeHolderImage)
                }
            }
        }
        
        //MARK: TextField
        Decor.styleTextField(nameTextField, placeholder: Constant.name)
        Decor.styleTextField(nickNameTextField, placeholder: Constant.nickName)
        Decor.styleTextField(birthdayTextField, placeholder: Constant.birthday)
        //MARK: DatePicker
        createDatePicker()
        
        setupDependencies()
        
        birthdayTextField.text = UserSettings.getObject(for: "birthday") as? String
    }
    
    private func setupDependencies() {
        viewModel = ProfileViewModel(view: self)
        router = ProfileRouter(viewController: self)
    }
    
    private func settingNavigationItem() {
        navigationItem.title = Constant.edit
        navigationItem.rightBarButtonItem?.title = Constant.doneButton
    }
    
    private func createDatePicker() {
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.maximumDate = Date()
        datePicker.datePickerMode = .date
        birthdayTextField.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: Constant.doneButton, style: .plain, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        birthdayTextField.inputAccessoryView = toolbar
    }
    
    @objc private func doneAction() {
        self.view.endEditing(true)
    }
    
    @objc private func dateChanged() {
        getDateFromPicker()
    }
    
    private func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        birthdayTextField.text = formatter.string(from: datePicker.date)
        UserSettings.save(object: birthdayTextField.text ?? "", for: "birthday")
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
            nickNameTextField.becomeFirstResponder()
        } else if textField == nickNameTextField {
            textField.resignFirstResponder()
            birthdayTextField.becomeFirstResponder()
        }
        return true
    }
}

extension ProfileViewController: ProfileDelegate {
    func updateProfile(user:Contact) {
        DispatchQueue.main.async {
            self.nameTextField.text = user.name
            self.nickNameTextField.text = user.nickname
        }
    }
}
