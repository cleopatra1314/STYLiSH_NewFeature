//
//  PromotionTableViewCell.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/6.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit


class PromotionTableViewCell: UITableViewCell{
    
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
    let itemImageView = UIImageView()
    let goToDivinationButton: UIButton = {
        let goToDivinationButton = UIButton()
        goToDivinationButton.backgroundColor = .blue
        goToDivinationButton.setTitle("抽優惠", for: .normal)
        
        return goToDivinationButton
    }()
    
    
    func layoutCell(){
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(dialogView)
        dialogView.addSubview(itemImageView)
        dialogView.addSubview(goToDivinationButton)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        dialogView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        goToDivinationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: dialogView.topAnchor, constant: 16),
            itemImageView.leadingAnchor.constraint(equalTo: dialogView.leadingAnchor, constant: 16),
            itemImageView.widthAnchor.constraint(equalToConstant: 180),
            itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor, multiplier: 220/180),
            itemImageView.trailingAnchor.constraint(equalTo: dialogView.trailingAnchor, constant: -16),
            goToDivinationButton.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 8),
            goToDivinationButton.heightAnchor.constraint(equalToConstant: 40),
            goToDivinationButton.widthAnchor.constraint(equalToConstant: 120),
            goToDivinationButton.centerXAnchor.constraint(equalTo: dialogView.centerXAnchor),
            goToDivinationButton.bottomAnchor.constraint(equalTo: dialogView.bottomAnchor, constant: -16),
            profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            profileImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 1),
            dialogView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            dialogView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
//            dialogView.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -16),
            dialogView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
        
        
    }
    
}

