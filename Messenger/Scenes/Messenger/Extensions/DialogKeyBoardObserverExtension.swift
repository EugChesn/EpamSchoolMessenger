//
//  DialogKeyBoardObserverExtension.swift
//  Messenger
//
//  Created by Евгений Гусев on 31.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

extension DialogViewController {
    func addKeyBoardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyBoardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        var newDistance = -keyboardSize.height
        var collectionViewInset = keyboardSize.height
            
        let window = UIApplication.shared.keyWindow
        
        if let bottom = window?.safeAreaInsets.bottom {
            newDistance += bottom
            collectionViewInset -= bottom
        }
        
        if let viewModel = viewModel {
            chatLogCollectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58 + collectionViewInset, right: 0)
            chatLogCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50 + collectionViewInset, right: 0)
            
            chatLogCollectionView.scrollToItem(at: IndexPath(row: viewModel.messageCount - 1, section: 0), at: .bottom, animated: false)
            
            inputTextFiledBottomConstraint.constant = newDistance
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        chatLogCollectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        chatLogCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        inputTextFiledBottomConstraint.constant = 0
    }
}
