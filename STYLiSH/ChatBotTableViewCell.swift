//
//  ChatBotTableViewCell.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/6.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit


class ChatBotTableViewCell: UITableViewCell{
    
    let profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "Icon_chatbot.png")
        return profileImageView
    }()
    let dialogTextView: UITextView = {
        let dialogTextView = UITextView()
        dialogTextView.textContainerInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        dialogTextView.backgroundColor = UIColor(ciColor: CIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1))
        dialogTextView.layer.cornerRadius = 16
        dialogTextView.isScrollEnabled = false
//        dialogTextView.
        return dialogTextView
    }()
    
    func layoutCell(){
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(dialogTextView)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        dialogTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 1),
            dialogTextView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            dialogTextView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            dialogTextView.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -16),
            dialogTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
        
        
    }
    
}