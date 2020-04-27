//
//  DialogViewController.swift
//  Messenger
//
//  Created by Евгений Гусев on 15.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import FirebaseUI

protocol DialogDelegate: class {
    func updateChatLog()
    func insertMessage(index: Int)
    
    func updateStatus(status: String)
}

class DialogViewController: UIViewController {
    var viewModel: DialogViewModeling?
    var router: DialogRouting?
    
    var closureBackTime: ((String) -> ())?
    
    var chatInfo: ChatInfo?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var chatLogCollectionView: UICollectionView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var inputTextFiledBottomConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDependencies()
        setupUI()
        viewModel?.updateChatLog()
        viewModel?.startCheckStatusTimer()
    }
  
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.5, animations: {
            self.tabBarController?.tabBar.isHidden = false })
        if let time = viewModel?.chat?.contact.time {
            closureBackTime?(time)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.5, animations: {
            self.tabBarController?.tabBar.isHidden = true })
    }
    
    deinit {
        removeKeyBoardObservers()
        viewModel?.stopCheckStatusTimer()
    }
    
    func setupDependencies() {
        viewModel = DialogViewModel(view: self)
        viewModel?.chat = chatInfo
        router = DialogRouter(viewController: self)
    }
    
    func setupUI() {
        navigationController?.navigationBar.tintColor = .white
        
        backgroundImageView.image = UIImage(named: viewModel!.background)
        backgroundImageView.contentMode = .scaleToFill
        
        chatLogCollectionView.delegate = self
        chatLogCollectionView.dataSource = self

        chatLogCollectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        chatLogCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        chatLogCollectionView.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: "messageCell")
        
        messageTextField.layer.cornerRadius = 17
        messageTextField.layer.masksToBounds = true
        messageTextField.layer.borderWidth = 0.5
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 6.0, height: 2.0))
         messageTextField.leftView = leftView
         messageTextField.leftViewMode = .always
        
        var subtitleStatus: String!
        if let newTime = viewModel?.chat?.contact.time {
            subtitleStatus = Date.getStatusBaseOnTime(newTime: newTime)
        }
        let titleStackView: UIStackView = {
            let titleLabel = UILabel()
            titleLabel.textAlignment = .center
            titleLabel.font = .boldSystemFont(ofSize: 17)
            titleLabel.text = viewModel?.chat?.contact.name
            titleLabel.textColor = .white
            let subtitleLabel = UILabel()
            subtitleLabel.textAlignment = .center
            subtitleLabel.font = UIFont.systemFont(ofSize: 10)
            subtitleLabel.textColor = .white
            subtitleLabel.text = subtitleStatus
            let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
            stackView.axis = .vertical
            stackView.spacing = 5
            return stackView
        }()
        navigationItem.titleView = titleStackView
        
        addKeyBoardObservers()
    }

    @IBAction func sendMessage(_ sender: Any) {
        guard let text = messageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        viewModel?.sendMessage(messageText: text)
        messageTextField.text = nil
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        messageTextField.resignFirstResponder()
    }
}

extension DialogViewController: DialogDelegate {
    func updateStatus(status: String) {
        let title = navigationItem.titleView as! UIStackView
        title.subviews.enumerated().forEach { (index, view) in
            if index == 1 {
                if let label = view as? UILabel {
                    label.text = status
                }
            }
        }
        DispatchQueue.main.async {
            self.navigationItem.titleView = title
        }
    }
    
    func updateChatLog() {
        DispatchQueue.main.async {
            self.chatLogCollectionView.reloadData()
            
            if let viewModel = self.viewModel {
                self.chatLogCollectionView.scrollToItem(at: IndexPath(row: viewModel.messageCount - 1 , section: 0), at: .bottom, animated: false)
            }
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
