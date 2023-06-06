//
//  ButtonTableViewCell.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit


class ButtonTableViewCell: UITableViewCell{
    
    let divinationButton: UIButton = {
        let divinationButton = UIButton()
        divinationButton.translatesAutoresizingMaskIntoConstraints = false
        divinationButton.backgroundColor = UIColor(red: 0.75, green: 0.23, blue: 0.197, alpha: 1)
        divinationButton.layer.cornerRadius = 4
        
        return divinationButton
    }()
    
    func layoutCell(){
        
        self.contentView.addSubview(divinationButton)
        
        NSLayoutConstraint.activate([
            divinationButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            divinationButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            divinationButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            divinationButton.heightAnchor.constraint(equalToConstant: 56),
            divinationButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
    
    }
    
    
}

