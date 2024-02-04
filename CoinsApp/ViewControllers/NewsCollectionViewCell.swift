//
//  NewsCollectionViewCell.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 01.02.24.
//

import UIKit

final class NewsCollectionViewCell: UICollectionViewCell {
    static let id = "\(NewsCollectionViewCell.self)"
    
    private var sourceLabel = UILabel()
    private var newsImageView = UIImageView()
    private var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        newsImageView.image = nil
        setupViews()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(news: NewArticle) {
        sourceLabel.text = news.source ?? ""
        titleLabel.text = news.title ?? ""
        
        guard let imageView = news.imgUrl else { return }
        newsImageView.loadImage(imageURL: imageView)
    }
    
    private func setupViews() {
        layer.cornerRadius = 10
        backgroundColor = .cellColor
        

        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        sourceLabel.numberOfLines = 0
        sourceLabel.font = .systemFont(ofSize: 17, weight: .bold)
        newsImageView.clipsToBounds = true
        newsImageView.layer.cornerRadius = 10
        newsImageView.contentMode = .scaleToFill
        addSubview(sourceLabel)
        addSubview(titleLabel)
        addSubview(newsImageView)
    }
    
    private func autoLayout() {
        [sourceLabel, titleLabel, newsImageView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
            NSLayoutConstraint.activate([
                newsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                newsImageView.widthAnchor.constraint(equalToConstant: 100),
                
                sourceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                sourceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                sourceLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -8),
                
                titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 8),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                titleLabel.trailingAnchor.constraint(equalTo: sourceLabel.trailingAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
}
