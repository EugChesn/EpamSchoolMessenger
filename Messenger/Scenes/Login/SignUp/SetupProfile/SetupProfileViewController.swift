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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleTextField(nameTextFiled)
        Utilities.styleTextField(nicknameTextField)
        Utilities.styleButton(goChatsButton)
        Utilities.styleImageView(photoNewUserImageView)
        setupDependencies()
    }
    
    @IBAction func tapAddPhoto(_ sender: UIButton) {
        let imagePicker = UIImagePickerController() // 1
        imagePicker.delegate = self // 2
        self.present(imagePicker, animated: true, completion: nil) // 3
    }
    
    @IBAction func goToChatsTap(_ sender: UIButton) {
        guard let name = nameTextFiled.text else {return}
        guard let nick = nicknameTextField.text else {return}
        guard let photo = photoNewUserImageView.image else {return}
        viewModel?.setupProfileUser(name: name, nickname: nick, photo: photo)
    }
    
    func setupDependencies() {
        viewModel = SetupProfileViewModel(view: self)
        router = SetupProfileRouter(viewController: self)
    }
    func Test_FirebaseUI_Download() {
        // Reference to an image file in Firebase Storage
        let reference = StorageService.shared.storageRef.child(Auth.auth().currentUser!.uid)

        // UIImageView in your ViewController
        let imageView: UIImageView = self.photoNewUserImageView

        // Placeholder image
        let placeholderImage = UIImage(named: "placeholder.jpg")

        // Load the image using SDWebImage
        imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
    }
}

extension SetupProfileViewController: SetupProfileDelegate {
    func profileSucces() {
        router?.routeToChat(withIdentifier: "profileToMessanger", sender: self)
    }
}

extension SetupProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imageFromPC = info[UIImagePickerController.InfoKey.originalImage] as! UIImage // 1
        photoNewUserImageView.image = imageFromPC // 2
        self.dismiss(animated: true, completion: nil) // 3
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
