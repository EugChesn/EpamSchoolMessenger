//
//  CreateChatViewController.swift
//  Messenger
//
//  Created by Admin on 24.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import UIKit
protocol CreateChatDelegate: class {
    func chatCreateSuccess()
}

class CreateChatViewController: UIViewController {
    var viewModel: CreateChatModeling?
    //var router : CreateChatRouting?
    let router = CreateChatRouter()
    var firebaseService : FirebaseService?
    
    
    @IBOutlet weak var chatNameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func createButtonPressed(_ sender: Any) {
        chatNameInput.endEditing(true)
        chatNameInput.isEnabled = false
        guard let chatName = chatNameInput.text else {return}
        viewModel?.createNewChat(chatName: chatName)
        chatCreateSuccess()
    }
    
    
    
    func createNewChat(chatName: String){
    // let user = firebaseService?.getCurrentUser()
     let chatsDB = firebaseService?.referenceDataBase.database.reference().child("Chats")
         let chatsDictionary = ["name":chatName]
         chatsDB?.childByAutoId().setValue(chatsDictionary){ (error, reference) in
             if let error = error {
                 print(error)
             }
            print(reference)
         }
     }
    
}

extension CreateChatViewController: CreateChatDelegate {
    func chatCreateSuccess() {
        router.dismissModalView(viewController: self)
    }
}
