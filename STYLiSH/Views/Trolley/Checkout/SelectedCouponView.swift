//
//  SelectedCouponView.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/6.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class SelectedCouponView: UIView {

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
    
    private let couponImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "free_shipping")
        return imageView
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
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "尚未選擇折價卷"
        label.font = .regular(size: 16)
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        [labelsContainerView].forEach { addSubview($0) }
        [couponName, couponDiscount, couponExpirationDate, couponImageView, label].forEach {
            labelsContainerView.addSubview($0)
        }
        
        configure(hasCoupon: false)
        
        NSLayoutConstraint.activate([
            labelsContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelsContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
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
            
            label.centerXAnchor.constraint(equalTo: labelsContainerView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: labelsContainerView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String,
                   couponDiscountText: Int,
                   couponExpirationDateText: String?) {
        let validDate = couponExpirationDateText != nil ? couponExpirationDateText?.split(separator: "T")[0] : "永遠有效"
        
        var couponNameText: String {
            switch title {
            case "deal items": return "特定品項"
            case "fixed_amout": return "現金"
            case "free_shipping": return "運費"
            default: return ""
            }
        }
        couponName.text = "\(couponNameText)折價卷"
        couponDiscount.text = "折$\(couponDiscountText)"
        couponExpirationDate.text = "有效期限 \(validDate!)"
        couponImageView.image = UIImage(named: title)
    }
    
    func configure(hasCoupon: Bool) {
        if hasCoupon {
            couponName.isHidden = false
            couponDiscount.isHidden = false
            couponExpirationDate.isHidden = false
            couponImageView.isHidden = false
            label.isHidden = true
        } else {
            couponName.isHidden = true
            couponDiscount.isHidden = true
            couponExpirationDate.isHidden = true
            couponImageView.isHidden = true
            label.isHidden = false
        }
    }
}
