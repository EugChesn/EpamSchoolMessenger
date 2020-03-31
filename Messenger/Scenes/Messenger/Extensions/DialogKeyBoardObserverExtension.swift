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
    private func addKeyBoardObservers() {
        showKeyBoardObserver = NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        hideKeyBoardObserver = NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyBoardObservers() {
        guard let showObserver = showKeyBoardObserver, let hideObserver = hideKeyBoardObserver else { return }
        NotificationCenter.default.removeObserver(showObserver)
        NotificationCenter.default.removeObserver(hideObserver)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
            
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

      self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {

      self.view.frame.origin.y = 0
    }
}
