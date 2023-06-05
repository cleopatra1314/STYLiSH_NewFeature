//
//  ColorTableViewCell.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import Foundation
import UIKit

class ColorTableViewCell: UITableViewCell{
    
    let colorLabel: UILabel = {
        let colorLabel = UILabel()
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return colorLabel
    }()
    let colorStack: UIStackView = {
        let colorStack = UIStackView()
        colorStack.distribution = .equalSpacing
        colorStack.translatesAutoresizingMaskIntoConstraints = false
        
        return colorStack
    }()
    var colorButtonsArray = [UIButton]()
    var indexOfSelectedColor: Int?
    
    
    func layoutColorBall(arrayOfColor: Array<String>){
        
        for index in 1...arrayOfColor.count{
            let colorBallButton = UIButton()

            colorBallButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            colorBallButton.layer.borderColor = UIColor.darkGray.cgColor
            colorBallButton.backgroundColor = UIColor.hexStringToUIColor(hex: arrayOfColor[index - 1])
            colorBallButton.addTarget(self, action: #selector(colorButtonTouchUpInside), for: .touchUpInside)
            colorBallButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                colorBallButton.heightAnchor.constraint(equalToConstant: 40),
                colorBallButton.widthAnchor.constraint(equalTo: colorBallButton.heightAnchor)
            ])
            colorBallButton.layer.cornerRadius = 20
            colorStack.addArrangedSubview(colorBallButton)
            colorButtonsArray.append(colorBallButton)
        }
        
    }
    
    
    func layoutCell(){
        
        self.contentView.addSubview(colorLabel)
        self.contentView.addSubview(colorStack)
        
        NSLayoutConstraint.activate([
            colorLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            colorLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            colorStack.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 12),
            colorStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 24),
            colorStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24),
            colorStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12)
        ])
        
    }
    
    
    @objc func colorButtonTouchUpInside(sender: UIButton){
        
        sender.isSelected.toggle()
        for (i, button) in colorButtonsArray.enumerated(){
            if button != sender{
                button.isSelected = false
            }else{
                indexOfSelectedColor = i
            }
            button.layer.borderWidth = button.isSelected ? 2 : 0
        }
        
    }
    
    
}
