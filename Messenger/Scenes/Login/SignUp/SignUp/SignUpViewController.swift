//
//  SignUpViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 11.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

protocol SignUpDelegate: class {
    func successCreateUser()
    func faultCreateUser(err: Error)
}

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var photoProfile: UIImageView!
    @IBOutlet weak var labelPhoto: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var StackContent: UIStackView!
    
    var viewModel: SignUpViewModeling?
    var router: SignUpRouting?
    private lazy var imagePicker = ImagePicker()
    let color = "3B8AC4"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.styleTextField(placeholder: "Name", colorLine: color)
        nickTextField.styleTextField(placeholder: "Nickname", colorLine: color)
        emailTextField.styleTextField(placeholder: "Email", colorLine: color)
        passwordTextField.styleTextField(placeholder: "Password", colorLine: color)
        photoProfile.roundWithBorder(colorLine: color)
        signUpButton.styleButton()
        
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.imageTapped))
        photoProfile.addGestureRecognizer(pictureTap)
        photoProfile.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        imagePicker.delegate = self
        emailTextField.delegate = self
        nameTextField.delegate = self
        nickTextField.delegate = self
        passwordTextField.delegate = self
        
        setupDependencies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindRegister"{
            if let destination = segue.destination as? ChatsViewController {
                destination.viewModel.downloadAndObserveChats()
            }
        }
    }
    
    func setupDependencies() {
        viewModel = SignUpViewModel(view: self)
        router = SignUpRouter(viewController: self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) { // условие поднятие content view под вопросом
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.frame.origin.y == 0 {
                if screenType == .iPhones_5_5s_5c_SE &&  nameTextField.isFirstResponder {
                    UIView.animate(withDuration: 1, animations: {
                        self.view.frame.origin.y -= (keyboardSize.height - 100)
                    })
                }
            }
        }
    }
    @objc func keyboardWillHide() {
        if passwordTextField.resignFirstResponder() {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func imageTapped() {
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
    
    private func alertErrorName(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func signUpTap(_ sender: UIButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let pass = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard let nick = nickTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        if ((!name.isValidName()) || (!nick.isValidName())) {
            alertErrorName(errorMessage: "Invalid name.")
        } else if !email.isValidateEmail() {
            alertError(errorCode: .invalidEmail)
        } else if !pass.isValidatePass() {
            alertError(errorCode: .weakPassword)
        } else {
            viewModel?.registerUser(name: name, nick: nick, email: email, password: pass, image: photoProfile.image)
            let activity = ManagerActivityIndicator.styleActivity(message: "Register...", type: .ballClipRotate)
            ManagerActivityIndicator.startAnimating(activity: activity)
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
            nickTextField.becomeFirstResponder()
        } else if textField == nickTextField {
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == passwordTextField) {
            let currentText = textField.text! + string
            if !(currentText.count <= Utilities.maxLenPassword) {
                textField.shake()
                return false
            }
        } else if (textField == emailTextField) {
            let currentText = textField.text! + string
            if !(currentText.count <= Utilities.maxLenEmail) {
                textField.shake()
                return false
            }
        } else {
            let currentText = textField.text! + string
            if !(currentText.count <= Utilities.maxLenEmail) {
                textField.shake()
                return false
            }
        }
        
        return true;
    }
}

extension SignUpViewController: SignUpDelegate {
    func faultCreateUser(err: Error) {
        ManagerActivityIndicator.stopAnimating()
        if let errorCode = AuthErrorCode(rawValue: err._code) {
            alertError(errorCode: errorCode)
        } else {
            alertErrorName(errorMessage: err.localizedDescription)
        }
    }
    func successCreateUser() {
        ManagerActivityIndicator.stopAnimating()
        router?.routeToChat(withIdentifier: "UnwindRegister", sender: self)
    }
}

extension SignUpViewController: ImagePickerDelegate  {
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        photoProfile.image = image
        labelPhoto.isHidden = true
        imagePicker.dismiss()
    }

    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) {
        if photoProfile.image == nil {
            labelPhoto.isHidden = false
        }
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
