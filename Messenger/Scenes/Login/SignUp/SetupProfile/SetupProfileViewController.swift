//
//  SetupProfileViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 13.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI

protocol SetupProfileDelegate: class {
    func profileSucces()
}

class SetupProfileViewController: UIViewController {
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var goChatsButton: UIButton!
    @IBOutlet weak var photoNewUserImageView: UIImageView!
    
    var viewModel: SetupProfileViewModeling?
    var router: SetupProfileRouting?
    private lazy var imagePicker = ImagePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleTextField(nameTextFiled)
        Utilities.styleTextField(nicknameTextField)
        Utilities.styleButton(goChatsButton)
        Utilities.styleImageView(photoNewUserImageView)
        
        imagePicker.delegate = self
        nameTextFiled.delegate = self
        nicknameTextField.delegate = self
        setupDependencies()
    }
    
    @IBAction func tapAddPhoto(_ sender: UIButton) {
        nameTextFiled.resignFirstResponder()
        nicknameTextField.resignFirstResponder()
        
        imagePicker.photoGalleryAsscessRequest()
        //imagePicker.cameraAsscessRequest()
    }
    
    @IBAction func goToChatsTap(_ sender: UIButton) {
        guard let name = nameTextFiled.text else {return}
        guard let nick = nicknameTextField.text else {return}
        guard let photo = photoNewUserImageView.image else {return}
        viewModel?.setupProfileUser(name: name, nickname: nick, photo: photo)
        let activity = ManagerActivityIndicator.styleActivity(message: "Profile creating..", type: .ballClipRotate)
        ManagerActivityIndicator.startAnimating(activity: activity)
    }
    
    func setupDependencies() {
        viewModel = SetupProfileViewModel(view: self)
        router = SetupProfileRouter(viewController: self)
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
         imagePicker.present(parent: self, sourceType: sourceType)
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindRegister"{
            if let destination = segue.destination as? ChatsViewController {
                destination.viewModel.downloadChats()
            }
        }
    }
}

extension SetupProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextFiled {
            textField.resignFirstResponder()
            nicknameTextField.becomeFirstResponder()
        } else if textField == nicknameTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text! + string
        if !(currentText.count <= Utilities.maxLenText) {
            textField.shake()
            return false
        }
        return true
    }
}

extension SetupProfileViewController: SetupProfileDelegate {
    func profileSucces() {
        ManagerActivityIndicator.stopAnimating()
        router?.routeToChat(withIdentifier: "UnwindRegister", sender: self)
    }
}

extension SetupProfileViewController: ImagePickerDelegate  {
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        photoNewUserImageView.image = image
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
