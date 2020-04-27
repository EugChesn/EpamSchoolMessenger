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
    
    private enum Constants {
        static let topConstraint: CGFloat = 20.0
        static let seKeyboardOffset: CGFloat = 160.0
        static let keyboardAnimateDuration: Double = 0.5
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nickTextField: UITextField!
    @IBOutlet weak var photoProfile: UIImageView!
    @IBOutlet weak var labelPhoto: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var StackContent: UIStackView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var viewModel: SignUpViewModeling?
    var router: SignUpRouting?
    private lazy var imagePicker = ImagePicker()
    
    let blue = "3B8AC4"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(named: blue)
        nameTextField.styleTextField(placeholder: "Name", colorLine: blue)
        nickTextField.styleTextField(placeholder: "Nickname", colorLine: blue)
        emailTextField.styleTextField(placeholder: "Email", colorLine: blue)
        passwordTextField.styleTextField(placeholder: "Password", colorLine: blue)
        photoProfile.roundWithBorder(colorLine: blue)
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
        
        hideKeyboardWhenTappedAround()
        setupDependencies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindRegister" {
            if let destination = segue.destination as? ChatsViewController {
                destination.viewModel.downloadAndObserveChats()
            }
        }
    }
    
    func setupDependencies() {
        viewModel = SignUpViewModel(view: self)
        router = SignUpRouter(viewController: self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if screenType == .iPhones_5_5s_5c_SE {
            topConstraint.constant = Constants.topConstraint - Constants.seKeyboardOffset
            
            UIView.animate(withDuration: Constants.keyboardAnimateDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if screenType == .iPhones_5_5s_5c_SE {
            topConstraint.constant = Constants.topConstraint
            
            UIView.animate(withDuration: Constants.keyboardAnimateDuration) {
                self.view.layoutIfNeeded()
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
        actionSheet.view.tintColor = UIColor(named: blue)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func alertErrorName(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        alert.view.tintColor = UIColor(named: blue)
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
            nickTextField.becomeFirstResponder()
        } else if textField == nickTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
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
