//
//  AddContactViewController.swift
//  Messenger
//
//  Created by Maxim on 18.04.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit
protocol AddContactDelegate: class {
    func succeesAdd()
    func faultToAdd()
}

class AddContactViewController: UIViewController {
    var viewModel: AddContactViewModeling?
    var router: AddContactRouting?
    @IBOutlet weak var emailTextInput: UITextField!
    @IBOutlet weak var nicknameTextInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDependencies()
    }
    
    func setupDependencies() {
        viewModel = AddContactViewModel(view: self)
        router = AddContactRouter(viewController: self)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
      //  dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        guard let email = emailTextInput.text else {return}
        //guard let nickname = nicknameTextInput.text else {return}
        //viewModel?.searchForContact(nickname: nickname)
        var contact = Contact()
        //contact.nickname = nickname
        contact.email = email
        //viewModel?.searchForContact(userEmail: email)
        //viewModel?.addNewContact(contact: contact)
        //viewModel?.searchForUser(inputEmail: email)
        searchUser(userEmail: email)
    }
    
    func searchUser(userEmail: String){
        let rootRef = FirebaseService.firebaseService.referenceDataBase
        let email = userEmail
        rootRef.child("users").queryOrdered(byChild: "email").queryStarting(atValue: email).queryEnding(atValue: email + "\u{f8ff}").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists(){
                //print(snapshot)
                print(snapshot.children.allObjects[0])
                /*
                 How to get UID
                 Snap (Xn9EYXnmHrOtyOV1hPgOeLxMV9F3) {
                     email = "epam@nn.ru";
                     name = epam;
                     nickname = epam;
                     status = online;
                     time = "2020/Apr/23 18:49:55";
                 }
                 */
            } else if !snapshot.exists(){
                print("no such user")
            }
        }
    }
}

extension AddContactViewController: AddContactDelegate{
    func succeesAdd(){
        dismiss(animated: true, completion: nil)
    }
    func faultToAdd(){
        let alert = UIAlertController(title: "Wrong Email", message: "No such user registered. Please, check email.", preferredStyle: .alert)
               let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                   self.emailTextInput.text = ""
                self.nicknameTextInput.text = ""
               }
               alert.addAction(okAction)
               self.present(alert, animated: true, completion: nil)
    }
}
