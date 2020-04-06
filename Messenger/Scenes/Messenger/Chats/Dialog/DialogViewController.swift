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
    func insertMessage(index: Int)
}

class DialogViewController: UIViewController {
    var viewModel: DialogViewModeling!
    var router: DialogRouting?
    
    var chatInfo: ChatInfo?
    
    @IBOutlet weak var chatLogCollectionView: UICollectionView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var inputTextFiledBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDependencies()
        setupUI()
        viewModel.updateChatLog()
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    deinit {
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

        chatLogCollectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        chatLogCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
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
    
    @IBAction func hideKeyboard(_ sender: Any) {
        messageTextField.resignFirstResponder()
    }
}

extension DialogViewController: DialogDelegate {
    func updateChatLog() {
        DispatchQueue.main.async {
            self.chatLogCollectionView.reloadData()
            
            self.chatLogCollectionView.scrollToItem(at: IndexPath(row: self.viewModel.messageCount - 1 , section: 0), at: .bottom, animated: true)
        }
    }
    
    func insertMessage(index: Int) {
        DispatchQueue.main.async {
            self.chatLogCollectionView.performBatchUpdates({
                self.chatLogCollectionView.insertItems(at: [IndexPath(row: index, section: 0)])
            }, completion: nil)
            
            self.chatLogCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .bottom, animated: true)
        }
    }
}

