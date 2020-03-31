//
//  DialogViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 15.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

protocol DialogDelegate: class {
    func updateChatLog()
}

class DialogViewController: UIViewController {
    var viewModel: DialogViewModeling!
    var router: DialogRouting?
    
    var chatInfo: ChatInfo?
    
    var showKeyBoardObserver: Void?
    var hideKeyBoardObserver: Void?
    
    @IBOutlet weak var chatLogCollectionView: UICollectionView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var inputViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDependencies()
        setupUI()
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
        removeKeyBoardObservers()
    }
    
    func setupDependencies() {
        viewModel = DialogViewModel(view: self)
        viewModel.chat = chatInfo
        router = DialogRouter(viewController: self)
    }
    
    func setupUI() {
        chatLogCollectionView.delegate = self
        chatLogCollectionView.dataSource = self
        chatLogCollectionView.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: "messageCell")
        
        messageTextField.layer.cornerRadius = 15
        messageTextField.layer.masksToBounds = true
        messageTextField.layer.borderWidth = 0.5
        
        navigationItem.title = viewModel.chat?.contact.name
        
        self.tabBarController?.tabBar.isHidden = true
        
        addKeyBoardObservers()
    }

    @IBAction func sendMessage(_ sender: Any) {
        guard let text = messageTextField.text, text != "" else {
            return
        }
        
        viewModel.sendMessage(messageText: text)
        messageTextField.text = ""
    }
    
    @IBAction func tapForHideKeyBoard(_ sender: Any) {
        messageTextField.resignFirstResponder()

    }
}

extension DialogViewController: DialogDelegate {
    func updateChatLog() {
        DispatchQueue.main.async {
            self.chatLogCollectionView.reloadData()
        }
    }
}

