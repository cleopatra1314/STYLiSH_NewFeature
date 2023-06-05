//
//  RecommendedProductTableViewCell.swift
//  STYLiSH
//
//  Created by Lin Hsin-An on 2023/6/3.
//  Copyright © 2023 AppWorks School. All rights reserved.
//

import UIKit

class RecommendedProductTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: RecommendedProductTableViewCell.self)
    
    var data: [Product]? {
        didSet {
            collectionView.reloadData()
        }
    }
    var showDetailPage: ((IndexPath) -> Void)?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            // Define the layout for each section in the collection view
            // Item size
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            // Group size
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(300))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .medium(size: 24)
        label.text = "推薦商品"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add the collection view to the cell's content view
        [titlelabel, collectionView].forEach { contentView.addSubview($0) }
        
        // Set up the collection view constraints
        NSLayoutConstraint.activate([
            titlelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titlelabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            titlelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            collectionView.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // Configure the collection view
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecommendedProductCollectionViewCell.self,
                                forCellWithReuseIdentifier: RecommendedProductCollectionViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecommendedProductTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in the collection view
        if let data = data { return data.count } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecommendedProductCollectionViewCell.reuseIdentifier,
            for: indexPath)
        guard let cell = cell as? RecommendedProductCollectionViewCell,
              let data = data?[indexPath.row] else { return cell }
        
        // Configure the collection view cell
        cell.configure(with: data.mainImage,
                       label1Text: data.title,
                       label2Text: data.description)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetailPage?(indexPath)
    }
}

class RecommendedProductCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: RecommendedProductTableViewCell.self)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .regular(size: 14)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add the image view and labels to the cell's content view
        contentView.addSubview(imageView)
        contentView.addSubview(titlelabel)
        contentView.addSubview(descriptionlabel)
        
        // Set up the constraints for the UI components
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 220),
            
            titlelabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titlelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titlelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionlabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 8),
            descriptionlabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionlabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageName: String, label1Text: String, label2Text: String) {
        imageView.loadImage(imageName)
        titlelabel.text = label1Text
        descriptionlabel.text = label2Text
    }
}
