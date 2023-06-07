//
//  userChatTableViewCell.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/6.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit


class UserChatTableViewCell: UITableViewCell{
    
   let dialogTextView: UITextView = {
        let dialogTextView = UITextView()
        dialogTextView.textContainerInset = .init(top: 10, left: 12, bottom: 10, right: 12)
        dialogTextView.backgroundColor = UIColor(red: 54/255, green: 54/255, blue: 54/255, alpha: 1)
        dialogTextView.layer.cornerRadius = 20
        dialogTextView.isScrollEnabled = false

        return dialogTextView
    }()
    
    
    func layoutCell(){
        self.contentView.addSubview(dialogTextView)
        
        dialogTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dialogTextView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            dialogTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            dialogTextView.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: 16),
            dialogTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
        
        
    }
    
}

