//
//  DressTableViewCell.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/6.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit

class DressTableViewCell: UITableViewCell{
    
    let profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "Icon_chatbot.png")
        return profileImageView
    }()
    let dialogView: UIView = {
        let dialogView = UIView()
        dialogView.backgroundColor = .lightGray
        dialogView.layer.cornerRadius = 16
        return dialogView
    }()
    let itemTitlelabel = UILabel()
    let itemImageView = UIImageView()
    
    func layoutCell(){
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(dialogView)
        dialogView.addSubview(itemTitlelabel)
        dialogView.addSubview(itemImageView)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        itemTitlelabel.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTitlelabel.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 16),
            itemTitlelabel.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 16),
            itemImageView.topAnchor.constraint(equalTo: itemTitlelabel.bottomAnchor, constant: 8),
            itemImageView.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 16),
            itemImageView.widthAnchor.constraint(equalToConstant: 180),
            itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor, multiplier: 220/180),
            itemImageView.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: -16),
            itemImageView.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -16),
            profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 1),
            dialogView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            dialogView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
//            dialogView.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -16),
            dialogView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
        
        
    }
    
}
