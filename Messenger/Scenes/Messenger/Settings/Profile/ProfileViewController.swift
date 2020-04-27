//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Анастасия Демидова on 25.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

protocol ProfileDelegate: class {
    func updateProfile(user:Contact)
}

class ProfileViewController: UITableViewController {
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var nickNameTextField: UITextField!
    @IBOutlet private weak var birthdayTextField: UITextField!
    
    let datePicker = UIDatePicker()
    let placeHolderImage = UIImage(named: "profile")
    private lazy var imagePicker = ImagePicker()
    var checkChangePhoto: Bool = false
    var alertIndicator: UIAlertController!
    
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
    
        viewModel?.birthday = birthdayTextField.text ?? ""
        
        let curContact = viewModel?.contact
        if !name.isEmpty && !nickname.isEmpty {
            if curContact?.name != name || curContact?.nickname != nickname {
                let update = ["name": name, "nickname": nickname]
                self.viewModel?.updateDataProfile(update: update)
                self.viewModel?.updateUserDefaults(name, nickname)
                if !checkChangePhoto { self.router?.routeSettings() }
            }
        }
        
        if checkChangePhoto {
            guard let curImage = profileImage.image else { return }
            
            self.testIndicatorAlert()
            if let urlPhoto = curContact?.profileImageUrl {
                SDImageCache.shared.removeImage(forKey: urlPhoto) {
                    print("complete remove cash")
                    self.viewModel?.updatePhoto(photo: curImage) { newUrl in
                        self.dismiss(animated: true) {
                            self.router?.routeSettings()
                        }
                    }
                }
            } else {
                self.viewModel?.updatePhoto(photo: curImage) { newUrl in
                    self.dismiss(animated: true) {
                        self.router?.routeSettings()
                    }
                }
            }
        }
        
        self.router?.routeSettings()
    }
    
    func testIndicatorAlert() {
        alertIndicator = UIAlertController(title: nil, message: "Applying changes...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alertIndicator.view.addSubview(loadingIndicator)
        present(alertIndicator, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationItem()
        nameTextField.delegate = self
        nickNameTextField.delegate = self
        //LogOutButton.setTitle(Constant.exit, for: .normal)
        //MARK: Profile Image
        profileImage.roundWithBorder()
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.imageTapped))
        profileImage.addGestureRecognizer(pictureTap)
        profileImage.isUserInteractionEnabled = true
        imagePicker.delegate = self
        //MARK: TextField
        nameTextField.styleTextField(placeholder: Constant.name)
        nickNameTextField.styleTextField(placeholder: Constant.nickName)
        birthdayTextField.styleTextField(placeholder: Constant.birthday)
        birthdayTextField.text = UserSettings.getObject(for: ProfileSetting.birthday) as? String
        //MARK: DatePicker
        createDatePicker()
        
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
    
    @objc func imageTapped() {
        print("tap")
        alertSheetPhotoSource()
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
         imagePicker.present(parent: self, sourceType: sourceType)
    }
    private func alertSheetPhotoSource() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { action in
            self.imagePicker.cameraAsscessRequest()
        }
        let actionGalery = UIAlertAction(title: "Galery", style: .default) { action in
            self.imagePicker.photoGalleryAsscessRequest()
        }
        
        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionGalery)
        actionSheet.addAction(actionCancel)
        
        present(actionSheet, animated: true, completion: nil)
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
            let url = user.profileImageUrl
            if let urlPhoto = url {
                self.profileImage.sd_setImage(with: URL(string: urlPhoto), placeholderImage: nil, options: [], completed: nil)
            }
        }
    }
}

extension ProfileViewController: ImagePickerDelegate  {
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        profileImage.image = image
        checkChangePhoto = true
        imagePicker.dismiss()
    }

    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) {
        checkChangePhoto = false
        imagePicker.dismiss()
    }

    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed { presentImagePicker(sourceType: .photoLibrary) }
    }

    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        //Работает только на реальном устройстве
        if accessIsAllowed { presentImagePicker(sourceType: .camera) }
    }
}
