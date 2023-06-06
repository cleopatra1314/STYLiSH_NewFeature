//
//  DivinationTitleTableViewCell.swift
//  STYLiSH
//
//  Created by cleopatra on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit
import WebKit

class DivinationTitleTableViewCell: UITableViewCell {
    

    let pageTitleLabel: UILabel = {
        let pageTitleLabel = UILabel()
        pageTitleLabel.font = UIFont.systemFont(ofSize: 24)
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return pageTitleLabel
        
    }()
    
    let divinationImageView: UIImageView = {
        let divinationImageView = UIImageView()
        divinationImageView.contentMode = .scaleAspectFit
        divinationImageView.translatesAutoresizingMaskIntoConstraints = false
        divinationImageView.image = UIImage.gifImageWithName("draw")
        return divinationImageView
    }()
    

    func layoutCell(){
        self.contentView.addSubview(pageTitleLabel)
        self.contentView.addSubview(divinationImageView)
        
        //加入 gif 圖
//        if let url = Bundle.main.url(forResource: "draw", withExtension: "gif"){
//            let cfUrl = url as CFURL
//            CGAnimateImageAtURLWithBlock(cfUrl, nil) { (_, cgImage, _) in
//                titleCell.divinationImageView.image = UIImage(cgImage: cgImage)
//                return
//            }
//        }
        
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
