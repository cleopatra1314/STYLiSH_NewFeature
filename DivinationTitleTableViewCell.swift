//
//  DivinationTitleTableViewCell.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class DivinationTitleTableViewCell: UITableViewCell {
    

    let pageTitleLabel: UILabel = {
        let pageTitleLabel = UILabel()
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return pageTitleLabel
        
    }()
    let divinationImageView: UIImageView = {
        let divinationImageView = UIImageView()
        divinationImageView.contentMode = .scaleAspectFit
        divinationImageView.translatesAutoresizingMaskIntoConstraints = false
        return divinationImageView
        
    }()
    

    func layoutCell(){
        
        self.contentView.addSubview(pageTitleLabel)
        self.contentView.addSubview(divinationImageView)
        
        NSLayoutConstraint.activate([
            pageTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            pageTitleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            divinationImageView.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 6),
            divinationImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 32),
            divinationImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -32),
            divinationImageView.heightAnchor.constraint(equalTo: divinationImageView.widthAnchor, multiplier: 102/174),
            divinationImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
