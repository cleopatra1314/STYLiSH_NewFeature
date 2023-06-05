//
//  CouponView.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class CouponView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.lkCornerRadius = 10
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 18)
        label.text = "成功領取！"
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Icons_24px_Close"), for: .normal)
        return button
    }()
    
    private let leaveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("去商店逛逛", for: .normal)
        button.setTitleColor(.B1, for: .normal)
        button.titleLabel?.font = .regular(size: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.B1?.cgColor
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("FaceBook登入", for: .normal)
        button.setTitleColor(.B1, for: .normal)
        button.titleLabel?.font = .regular(size: 16)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.B1?.cgColor
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    var dismissView: (() -> Void)?
    var popToRootView: (() -> Void)?
    var loginToFacebook: (() -> Void)?
    
    @objc func closeButtonTapped() {
        dismissView?()
    }
    
    @objc func backToRoot() {
        popToRootView?()
    }
    
    @objc func onFacebookLogin() {
        loginToFacebook?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5.withAlphaComponent(0.8)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        [titleLabel, closeButton, leaveButton, loginButton].forEach { containerView.addSubview($0) }
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        leaveButton.addTarget(self, action: #selector(backToRoot), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(onFacebookLogin), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.widthAnchor.constraint(equalToConstant: 180),
            
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            closeButton.heightAnchor.constraint(equalToConstant: 18),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor, multiplier: 1),
            
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 6),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -16),
            
            leaveButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            leaveButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            leaveButton.widthAnchor.constraint(equalToConstant: 100),
            
            loginButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            loginButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggle(isSignedIn: Bool) {
        if isSignedIn {
            titleLabel.text = "成功領取！"
            leaveButton.isHidden = false
        } else {
            titleLabel.text = "請先登入再領取"
            loginButton.isHidden = false
        }
    }
}
