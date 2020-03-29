//
//  MessageCollectionViewCell.swift
//  Messenger
//
//  Created by Евгений Гусев on 29.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit



class MessageCollectionViewCell: UICollectionViewCell {
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.text = "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum"
        textView.backgroundColor = UIColor.blue
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var leftMessageAnchor: NSLayoutConstraint?
    var rightMessageAnhcor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textBubbleView)
        addSubview(messageTextView)
        
        
        textBubbleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        textBubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textBubbleView.widthAnchor.constraint(equalToConstant: 240).isActive = true
        
        leftMessageAnchor = textBubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        rightMessageAnhcor = textBubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        
        messageTextView.topAnchor.constraint(equalTo: textBubbleView.topAnchor).isActive = true
        messageTextView.rightAnchor.constraint(equalTo: textBubbleView.rightAnchor).isActive = true
        messageTextView.leftAnchor.constraint(equalTo: textBubbleView.leftAnchor).isActive = true
        
        messageTextView.heightAnchor.constraint(equalToConstant: frame.height - 20).isActive = true
        messageTextView.widthAnchor.constraint(equalToConstant: 232).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
