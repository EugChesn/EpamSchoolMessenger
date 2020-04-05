//
//  MessageCollectionViewCell.swift
//  Messenger
//
//  Created by Евгений Гусев on 29.03.2020.
//  Copyright © 2020 Anastasia Demidova. All rights reserved.
//

import Foundation
import UIKit

enum CellColor {
    case blue
    case gray
}

class MessageCollectionViewCell: UICollectionViewCell {
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .white
        textView.text = ""
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 0, green: 0.65, blue: 1.0, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    private var leftMessageAnchor: NSLayoutConstraint?
    private var rightMessageAnchor: NSLayoutConstraint?
    var bubbleWidthAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bubbleView)
        addSubview(messageTextView)
        
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        
        leftMessageAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        rightMessageAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        
        messageTextView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        messageTextView.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        messageTextView.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        messageTextView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(color: CellColor) {

        switch color {
        case .blue:
            leftMessageAnchor?.isActive = false
            rightMessageAnchor?.isActive = true
            messageTextView.textColor = .white
            bubbleView.backgroundColor = UIColor(red: 0, green: 0.65, blue: 1.0, alpha: 1.0)
        case .gray:
            leftMessageAnchor?.isActive = true
            rightMessageAnchor?.isActive = false
            bubbleView.backgroundColor = .lightGray
            messageTextView.textColor = .black
        }
    }
    
    
}
