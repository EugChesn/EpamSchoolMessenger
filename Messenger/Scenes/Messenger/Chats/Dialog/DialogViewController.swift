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
    
}

class DialogViewController: UIViewController {
    var viewModel: DialogViewModeling?
    var router: DialogRouting?
    
    var currentChat: Chat?
    
    @IBOutlet weak var chatLogCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentChat)
        setupUI()
        setupDependencies()
    }
    
    
    func setupDependencies() {
        viewModel = DialogViewModel(view: self)
        router = DialogRouter(viewController: self)
    }
    
    func setupUI() {
        chatLogCollectionView.delegate = self
        chatLogCollectionView.dataSource = self
        chatLogCollectionView.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: "messageCell")
    }
}

extension DialogViewController: DialogDelegate {
    
}

extension DialogViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath) as? MessageCollectionViewCell {
            cell.leftMessageAnchor?.isActive = false
            cell.rightMessageAnhcor?.isActive = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
            return cell
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum"

        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: message).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
    }

}
