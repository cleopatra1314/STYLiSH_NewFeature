//
//  CupView.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/6.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class CupView: UIView {
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .medium(size: 20)
        label.textColor = .B1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 18)
        label.textColor = .B1
        label.numberOfLines = 0
        return label
    }()
    
    let cupImageView: UIImageView = {
        let cupImageView = UIImageView()
        cupImageView.contentMode = .scaleAspectFill
        cupImageView.clipsToBounds = true
        cupImageView.translatesAutoresizingMaskIntoConstraints = false
        cupImageView.image = UIImage.gifImageWithName("goodCup")
        cupImageView.layer.cornerRadius = 20
        cupImageView.layer.shadowColor = UIColor.black.cgColor
        cupImageView.layer.shadowOpacity = 0.5
        cupImageView.layer.shadowOffset = .zero
        cupImageView.layer.shadowRadius = 2
        return cupImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(cupImageView)
        addSubview(labelsContainerView)
        labelsContainerView.addSubview(titleLabel)
        labelsContainerView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            labelsContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelsContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            //labelsContainerView.bottomAnchor.constraint(equalTo: cupImageView.topAnchor, constant: -32),
            labelsContainerView.widthAnchor.constraint(equalToConstant: 250),
            labelsContainerView.heightAnchor.constraint(equalToConstant: 170),
            
            titleLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: labelsContainerView.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: labelsContainerView.centerXAnchor, constant: 4),
            
            cupImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cupImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cupImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cupImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            cupImageView.widthAnchor.constraint(equalToConstant: 400),
            cupImageView.heightAnchor.constraint(equalTo: cupImageView.widthAnchor, multiplier: 0.5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, subtitle: String) {
        titleLabel.text = "抽中\(title)！"
        subtitleLabel.text = subtitle
        if ["大吉籤", "上上籤", "上中籤"].contains(title) {
            cupImageView.image = UIImage.gifImageWithName("goodCup")
        } else {
            cupImageView.image = UIImage.gifImageWithName("badCup")
        }
    }
}
