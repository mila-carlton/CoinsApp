//
//  NewsCollectionViewCell.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 01.02.24.
//

import UIKit

final class NewsCollectionViewCell: UICollectionViewCell {
    static let id = "\(NewsCollectionViewCell.self)"
    
    var sourceLabel = UILabel()
    var image = UIImageView()
    var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = 10
        
        contentView.addSubview(sourceLabel)
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
    }
    
    private func autoLayout() {
        [sourceLabel, image, titleLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
            NSLayoutConstraint.activate([
                image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
                image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
                image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                
                sourceLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
                sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
                
                titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 15),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)
        ])
    }
    
    func configure(news: NewArticle) {
        sourceLabel.text = news.source ?? ""
        titleLabel.text = news.title ?? ""
        
        guard let imageView = news.imageUrl else { return }
        image.loadImage(imageURL: imageView)
    }
}
