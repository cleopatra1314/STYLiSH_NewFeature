//
//  BirthdayTableViewCell.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit



class BirthdayTableViewCell: UITableViewCell{
    
    
    let birthdayLabel: UILabel = {
        let birthdayLabel = UILabel()
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return birthdayLabel
    }()
//    let birthdayButton: UIButton = {
//        let birthdayButton = UIButton()
//        birthdayButton.translatesAutoresizingMaskIntoConstraints = false
//
//        return birthdayButton
//    }()
    let birthdayTextField: UITextField = {
        let birthdayTextField = UITextField()
        birthdayTextField.translatesAutoresizingMaskIntoConstraints = false
        //??
        birthdayTextField.borderStyle = .roundedRect
        birthdayTextField.placeholder = "選擇日期"
        birthdayTextField.textAlignment = .center
        
        return birthdayTextField
    }()
    let birthdayPicker: UIDatePicker = {
        let birthdayPicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            birthdayPicker.preferredDatePickerStyle = .wheels
        }
        birthdayPicker.datePickerMode = .date
        birthdayPicker.locale = Locale(identifier: "zh_Hans_CN")
        birthdayPicker.addTarget(self, action: #selector(birthdayPickerValueChanged), for: .valueChanged)
        
        
        return birthdayPicker
    }()
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 年 MM 月 dd 日"
        
        return formatter
    }()
    let constellationLabel: UILabel = {
        let constellationLabel = UILabel()
        constellationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return constellationLabel
    }()
    
    
    
    func layoutCell(){
        
        [birthdayLabel, birthdayTextField, constellationLabel].forEach { subview in
            self.contentView.addSubview(subview)
        }
        
        self.contentView.bringSubviewToFront(birthdayPicker)
        birthdayTextField.inputView = birthdayPicker
        
        NSLayoutConstraint.activate([
            birthdayLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            birthdayLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            birthdayTextField.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 8),
            birthdayTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            birthdayTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24),
            birthdayTextField.heightAnchor.constraint(equalToConstant: 32),
            constellationLabel.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 8),
            constellationLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            constellationLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12)
        ])
        
    }
    
    
    @objc func birthdayPickerValueChanged(_ sender: UIDatePicker) {
            let selectedDate = sender.date
            let formattedDate = formatter.string(from: selectedDate)
            birthdayTextField.text = formattedDate
            // 在此处执行其他操作，根据选中的日期进行逻辑处理
        }
    
}
