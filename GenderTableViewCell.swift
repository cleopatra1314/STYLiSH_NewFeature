//
//  genderTableViewCell.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit


class GenderTableViewCell: UITableViewCell{
    
    let genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        return genderLabel
    }()
//    let genderButton: UIButton = {
//        let genderButton = UIButton()
//        genderButton.translatesAutoresizingMaskIntoConstraints = false
//
//        return genderButton
//    }()
    let genderPicker: UIPickerView = {
        let genderPicker = UIPickerView()
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        
        return genderPicker
    }()
    
    
    func layoutCell(){
        
        self.contentView.addSubview(genderLabel)
//        self.contentView.addSubview(genderButton)
        self.contentView.addSubview(genderPicker)
        
        NSLayoutConstraint.activate([
            genderLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            genderLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            //            genderButton.heightAnchor.constraint(equalToConstant: 24),
            //            genderButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 6),
            //            genderButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            //            genderButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24),
            //            genderButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12)
            genderPicker.heightAnchor.constraint(equalToConstant: 60),
//            genderPicker.picker heightAnchor.constraint(equalToConstant: 60),
            genderPicker.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 6),
            genderPicker.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            genderPicker.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24),
            genderPicker.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12)
        ])
        
    }
    
    
    
}
