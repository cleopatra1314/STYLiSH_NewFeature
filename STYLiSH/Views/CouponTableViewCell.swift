//
//  CouponTableViewCell.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/2.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class CouponTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: CouponTableViewCell.self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 24)
        return label
    }()
    
    private let labelsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let couponName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 18)
        return label
    }()
    
    private let couponDiscount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 18)
        return label
    }()
    
    private let couponExpirationDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 14)
        return label
    }()
    
    private let button1: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("重抽", for: .normal)
        button.setTitleColor(.B1, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.B1?.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
        
    private let button2: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("領取", for: .normal)
        button.setTitleColor(.B1, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.B1?.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add the UI components to the cell's content view
        contentView.addSubview(titleLabel)
        contentView.addSubview(labelsContainerView)
        contentView.addSubview(buttonsStackView)
        
        labelsContainerView.addSubview(couponName)
        labelsContainerView.addSubview(couponDiscount)
        labelsContainerView.addSubview(couponExpirationDate)
        
        buttonsStackView.addArrangedSubview(button1)
        buttonsStackView.addArrangedSubview(button2)
        
        // Set up the constraints for the UI components
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            labelsContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            labelsContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelsContainerView.widthAnchor.constraint(equalToConstant: 250),
            labelsContainerView.heightAnchor.constraint(equalToConstant: 150),
            
            couponName.topAnchor.constraint(equalTo: labelsContainerView.topAnchor, constant: 8),
            couponName.centerXAnchor.constraint(equalTo: labelsContainerView.centerXAnchor),
            
            couponDiscount.centerXAnchor.constraint(equalTo: labelsContainerView.centerXAnchor),
            couponDiscount.centerYAnchor.constraint(equalTo: labelsContainerView.centerYAnchor),
            couponDiscount.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor, constant: -8),
            
            couponExpirationDate.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor, constant: -8),
            couponExpirationDate.bottomAnchor.constraint(equalTo: labelsContainerView.bottomAnchor, constant: -8),
            
            buttonsStackView.topAnchor.constraint(equalTo: labelsContainerView.bottomAnchor, constant: 8),
            buttonsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonsStackView.widthAnchor.constraint(equalTo: labelsContainerView.widthAnchor, multiplier: 1),
            buttonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String,
                   couponNameText: String,
                   couponDiscountText: String,
                   couponExpirationDateText: String) {
        titleLabel.text = title
        couponName.text = couponNameText
        couponDiscount.text = couponDiscountText
        couponExpirationDate.text = couponExpirationDateText
    }

}
