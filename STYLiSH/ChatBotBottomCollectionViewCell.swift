//
//  ChatBotBottomCell.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/6.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit


class ChatBotBottomCollectionViewCell: UICollectionViewCell{
    
//    let canMessageButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    let canMessageButton = UIButton()
    let titleOfButtonLabel: UILabel = {
        let titleOfButtonLabel = UILabel()
        titleOfButtonLabel.textColor = UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 1)
        titleOfButtonLabel.font = UIFont(name: "PingFangTC-Regular", size: 14)
        return titleOfButtonLabel
    }()
    var twitClosure: ((ChatBotBottomCollectionViewCell) -> Void)?
    
    func layoutCell(){
        contentView.addSubview(canMessageButton)
        canMessageButton.addSubview(titleOfButtonLabel)
        
        titleOfButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        canMessageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleOfButtonLabel.leadingAnchor.constraint(equalTo: canMessageButton.leadingAnchor, constant: 16),
            titleOfButtonLabel.trailingAnchor.constraint(equalTo: canMessageButton.trailingAnchor, constant: -16),
            titleOfButtonLabel.topAnchor.constraint(equalTo: canMessageButton.topAnchor, constant: 10),
            titleOfButtonLabel.bottomAnchor.constraint(equalTo: canMessageButton.bottomAnchor, constant: -10),
            canMessageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            canMessageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            canMessageButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            canMessageButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        canMessageButton.backgroundColor = .white
        canMessageButton.layer.cornerRadius = 20
        canMessageButton.layer.borderWidth = 1
        canMessageButton.layer.borderColor = UIColor(red: 131/255, green: 139/255, blue: 139/255, alpha: 1).cgColor
//        canMessageButton.setTitleColor(UIColor.black, for: .normal)
//        canMessageButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 8, right: 8)
        canMessageButton.addTarget(self, action: #selector(canMessageButtonTouchUpInside), for: .touchUpInside)
    }
    
    
    @objc func canMessageButtonTouchUpInside(){
        self.twitClosure!(self)
        print("點擊 \(self)")
    }
    
    
}
