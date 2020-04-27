//
//  DialogCollectionViewExtension.swift
//  Messenger
//
//  Created by Евгений Гусев on 31.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

extension DialogViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel?.messageCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath) as? MessageCollectionViewCell {

            if let message = viewModel?.message(atIndex: indexPath.row)
            {
                let estimatedFrame = estimateFrame(text: message.text)
                cell.bubbleWidthAnchor?.constant = estimatedFrame.width + 32

                if message.from == FirebaseService.firebaseService.currentUser?.uid {
                    cell.configCell(color: .blue)
                } else {
                    cell.configCell(color: .gray)
                }

                cell.messageTextView.text = message.text
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = viewModel?.message(atIndex: indexPath.row).text

        let estimatedFrame = estimateFrame(text: text ?? "")
        
        chatLogCollectionView.contentSize.height += estimatedFrame.height + 20
        
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
    }
    
    private func estimateFrame(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
        
        return estimatedFrame
    }
}
