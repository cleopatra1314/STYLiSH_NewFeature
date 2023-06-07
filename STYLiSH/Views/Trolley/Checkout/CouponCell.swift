//
//  CouponCell.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/5.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class CouponCell: UITableViewCell {
    static let reuseIdentifier = String(describing: CouponCell.self)
    
    var updateCells: (() -> ())?
    
    private let couponImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "free_shipping")
        return imageView
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
    
    private let checkbox: UIButton = {
        let button = UIButton(configuration: .plain())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        button.changesSelectionAsPrimaryAction = true
        button.configurationUpdateHandler = { button in
            var config = button.configuration
            config?.background.image = UIImage(systemName: button.isSelected ? "checkmark.square" : "square")
            config?.background.imageContentMode = .scaleAspectFill
            config?.background.backgroundColor = .white
            button.configuration = config
        }
        return button
    }()
    
    @objc func checkboxTapped(_ button: UIButton) {
        updateCells?()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [labelsContainerView, checkbox].forEach { contentView.addSubview($0) }
        [couponName, couponDiscount, couponExpirationDate, couponImageView].forEach {
            labelsContainerView.addSubview($0)
        }
        
        checkbox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            labelsContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -32),
            labelsContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
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
            
            checkbox.leadingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor, constant: 32),
            checkbox.centerYAnchor.constraint(equalTo: labelsContainerView.centerYAnchor),
            checkbox.widthAnchor.constraint(equalToConstant: 30),
            checkbox.heightAnchor.constraint(equalTo: checkbox.widthAnchor, multiplier: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with type: String,
                   couponDiscountText: Int,
                   couponExpirationDateText: String?) {
        let validDate = couponExpirationDateText != nil ? couponExpirationDateText?.split(separator: "T")[0] : "永遠有效"
        
        var couponNameText: String {
            switch type {
            case "deal items": return "特定品項"
            case "fixed_amout": return "現金"
            case "free_shipping": return "運費"
            default: return ""
            }
        }
        couponName.text = "\(couponNameText)折價卷"
        couponDiscount.text = "折$\(couponDiscountText)"
        couponExpirationDate.text = "有效期限 \(validDate!)"
        couponImageView.image = UIImage(named: type)
    }
    
    func selectCheckbox() {
        checkbox.isSelected = true
    }
    
    func deselectCheckbox() {
        checkbox.isSelected = false
    }
}
