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
    var twitClosure: ((ChatBotBottomCollectionViewCell) -> Void)?
    
    func layoutCell(){
        contentView.addSubview(canMessageButton)
        
        canMessageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            canMessageButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            canMessageButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            canMessageButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            canMessageButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        canMessageButton.backgroundColor = .blue
        canMessageButton.layer.cornerRadius = 20
        canMessageButton.layer.borderWidth = 3
        canMessageButton.layer.borderColor = UIColor.red.cgColor
        canMessageButton.setTitleColor(UIColor.black, for: .normal)
        canMessageButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 8, right: 8)
        canMessageButton.addTarget(self, action: #selector(canMessageButtonTouchUpInside), for: .touchUpInside)
    }
    
    
    @objc func canMessageButtonTouchUpInside(){
        self.twitClosure!(self)
        print("點擊 \(self)")
    }
    
    
}
