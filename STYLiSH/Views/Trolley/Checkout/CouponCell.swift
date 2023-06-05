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
    
    private let couponImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "free_shipping")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [couponImageView].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            couponImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            couponImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            couponImageView.heightAnchor.constraint(equalToConstant: 100),
            couponImageView.widthAnchor.constraint(equalTo: couponImageView.heightAnchor, multiplier: 1),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
