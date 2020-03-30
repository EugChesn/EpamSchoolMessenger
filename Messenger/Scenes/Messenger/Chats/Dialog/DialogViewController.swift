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
    
    weak var chatViewModel: ChatsViewModeling?
    
    @IBOutlet weak var chatLogCollectionView: UICollectionView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDependencies()
        setupUI()
    }
    
    
    func setupDependencies() {
        viewModel = DialogViewModel(view: self)
        viewModel.chat = chatViewModel?.selectedChat
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
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        guard let text = messageTextField.text, text != "" else {
            return
        }
        
        viewModel.sendMessage(messageText: text)
        messageTextField.text = ""
    }
}

extension DialogViewController: DialogDelegate {
    func updateChatLog() {
        DispatchQueue.main.async {
            self.chatLogCollectionView.reloadData()
        }
    }
}

extension DialogViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.messageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath) as? MessageCollectionViewCell {
            
            let message = viewModel.message(atIndex: indexPath.row)
            
            let estimatedFrame = estimateFrame(text: message.text)
            cell.bubbleWidthAnchor?.constant = estimatedFrame.width + 32

            if message.from == FirebaseService.firebaseService.getCurrentUser()?.uid {
                cell.configCell(color: .blue)
            } else {
                cell.configCell(color: .gray)
            }
            
            cell.messageTextView.text = message.text
            
            collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
            return cell
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = viewModel.message(atIndex: indexPath.row).text

        let estimatedFrame = estimateFrame(text: text)
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
    }
    
    private func estimateFrame(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
        
        return estimatedFrame
    }

}
