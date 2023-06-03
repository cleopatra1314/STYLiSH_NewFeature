//
//  DivinationTableViewCell.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/2.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class PoemTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: PoemTableViewCell.self)
    
    private let labelsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 24)
        label.text = "抽中上上籤！"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 18)
        label.text = "風恬浪靜可行舟， \n恰是中秋月一輪，\n凡事不須多憂慮， \n福祿自有慶家門。"
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add the labels to the cell's content view
        contentView.addSubview(labelsContainerView)
        labelsContainerView.addSubview(titleLabel)
        labelsContainerView.addSubview(subtitleLabel)
        
        // Set up the label constraints
        NSLayoutConstraint.activate([
            labelsContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelsContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelsContainerView.widthAnchor.constraint(equalToConstant: 250),
            labelsContainerView.heightAnchor.constraint(equalToConstant: 170),
            
            titleLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: labelsContainerView.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: labelsContainerView.centerXAnchor, constant: 4)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
