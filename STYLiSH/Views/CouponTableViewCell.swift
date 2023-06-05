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
        label.font = .medium(size: 24)
        return label
    }()
    
    private let labelsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.lkCornerRadius = 20
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 2
        return view
    }()
    
    private let couponName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 16)
        return label
    }()
    
    private let couponDiscount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 16)
        return label
    }()
    
    private let couponExpirationDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 15)
        return label
    }()
    
    private let couponImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let redoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("重抽", for: .normal)
        button.setTitleColor(.B1, for: .normal)
        button.titleLabel?.font = .regular(size: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.B1?.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
        
    private let receiveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("領取", for: .normal)
        button.setTitleColor(.B1, for: .normal)
        button.titleLabel?.font = .regular(size: 16)
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
        stackView.spacing = 8
        return stackView
    }()
    
    var showPopUpView: (() -> Void)?
    var popViewController: (() -> Void)?
    
    @objc func redrawCoupon() {
        print("redraw tapped")
        popViewController?()
    }
    
    @objc func receiveCoupon() {
        print("receive tapped")
        showPopUpView?()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add the UI components to the cell's content view
        [titleLabel, labelsContainerView, buttonsStackView].forEach { contentView.addSubview($0) }
        [couponName, couponDiscount, couponExpirationDate, couponImageView].forEach {
            labelsContainerView.addSubview($0)
        }
        [redoButton, receiveButton].forEach { buttonsStackView.addArrangedSubview($0) }
        
        redoButton.addTarget(self, action: #selector(redrawCoupon), for: .touchUpInside)
        receiveButton.addTarget(self, action: #selector(receiveCoupon), for: .touchUpInside)
        
        // Set up the constraints for the UI components
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            labelsContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            labelsContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelsContainerView.widthAnchor.constraint(equalToConstant: 280),
            labelsContainerView.heightAnchor.constraint(equalToConstant: 150),
            
            couponImageView.centerYAnchor.constraint(equalTo: labelsContainerView.centerYAnchor),
            couponImageView.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor, constant: 24),
            couponImageView.heightAnchor.constraint(equalToConstant: 80),
            couponImageView.widthAnchor.constraint(equalTo: couponImageView.heightAnchor, multiplier: 1),
            
            couponName.topAnchor.constraint(equalTo: couponImageView.topAnchor, constant: -4),
            couponName.leadingAnchor.constraint(equalTo: couponImageView.trailingAnchor, constant: 16),
            
            couponDiscount.centerYAnchor.constraint(equalTo: couponImageView.centerYAnchor),
            couponDiscount.leadingAnchor.constraint(equalTo: couponName.leadingAnchor),
            
            couponExpirationDate.leadingAnchor.constraint(equalTo: couponName.leadingAnchor),
            couponExpirationDate.bottomAnchor.constraint(equalTo: couponImageView.bottomAnchor, constant: 4),
            
            buttonsStackView.topAnchor.constraint(equalTo: labelsContainerView.bottomAnchor, constant: 16),
            buttonsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 40),
            buttonsStackView.widthAnchor.constraint(equalTo: labelsContainerView.widthAnchor, multiplier: 1),
            buttonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
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
        couponImageView.image = UIImage(named: "deal items")
    }

}
