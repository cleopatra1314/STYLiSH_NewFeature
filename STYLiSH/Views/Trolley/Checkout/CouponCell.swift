//
//  CouponTableViewCell.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/5.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class CouponCell: UITableViewCell {
    static let reuseIdentifier = String(describing: CouponCell.self)
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("選擇折價卷>>", for: .normal)
        button.setTitleColor(.B1, for: .normal)
        button.titleLabel?.font = .medium(size: 16)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add the labels to the cell's content view
        contentView.addSubview(button)
        
        // Set up the label constraints
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
