//
//  CouponTableViewCell.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/5.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class CouponCheckoutCell: UITableViewCell {
    static let reuseIdentifier = String(describing: CouponCheckoutCell.self)
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "選擇折價卷"
        label.font = .medium(size: 16)
        label.textAlignment = .center
        label.textColor = .B1
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.B1?.cgColor
        label.layer.cornerRadius = 10
        return label
    }()
    
    let selectedCouponView: SelectedCouponView = SelectedCouponView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add the labels to the cell's content view
        [label, selectedCouponView].forEach { contentView.addSubview($0) }
        
        // Set up the label constraints
        NSLayoutConstraint.activate([
            //label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            //label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            label.heightAnchor.constraint(equalToConstant: 50),
            
            selectedCouponView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            selectedCouponView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            selectedCouponView.heightAnchor.constraint(equalToConstant: 180),
            selectedCouponView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            selectedCouponView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            selectedCouponView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
