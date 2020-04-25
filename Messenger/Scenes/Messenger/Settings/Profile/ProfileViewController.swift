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
    @IBOutlet private weak var LogOutButton: UIButton!
    @IBOutlet private weak var EditPhotoButton: UIButton!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var nickNameTextField: UITextField!
    @IBOutlet private weak var birthdayTextField: UITextField!
    
    let datePicker = UIDatePicker()
    let placeHolderImage = UIImage(named: "profile")
    private lazy var imagePicker = ImagePicker()
    var checkChangePhoto: Bool = false
    
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
        
        if !name.isEmpty && !nickname.isEmpty {
            if viewModel?.userName != name || viewModel?.userNickname != nickname {
                let update = ["name": name, "nickname": nickname]
                self.viewModel?.updateDataProfile(update: update)
                self.viewModel?.updateUserDefaults(name, nickname)
            }
            if checkChangePhoto {
                self.viewModel?.updatePhoto(photo: profileImage.image!)
            }
        }
        router?.routeSettings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingNavigationItem()
        nameTextField.delegate = self
        nickNameTextField.delegate = self
        LogOutButton.setTitle(Constant.exit, for: .normal)
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
                let reference = StorageService.shared.getReference(url: urlPhoto)
                //self.profileImage.sd_setImage(with: reference, placeholderImage: self.placeHolderImage)
                
                /*let test = SDImageCache.shared.imageFromCache(forKey: urlPhoto)
                self.profileImage.image = test*/
                SDImageCache.shared.removeImage(forKey: urlPhoto) {
                    print("complete remove cash")
                    self.profileImage.sd_setImage(with: URL(string: urlPhoto), placeholderImage: nil, options: .refreshCached)
                }
                
                /*StorageService.shared.downloadImage(ref: reference) { image in
                    self.profileImage.image = image
                }*/
                
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
