//
//  DetailsTableViewCell.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 02.02.24.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    static let id = "\(DetailsTableViewCell.self)"
    
    private let sourceLabel = UILabel()
    private let titleLabel = UILabel()
    private let detailImage = UIImageView()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        autoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(sourceLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailImage)
        
        titleLabel.numberOfLines = 0
        sourceLabel.numberOfLines = 0
        backgroundColor = .cellColor
        detailImage.contentMode = .scaleAspectFit
    
    }
    
    func configure(newsItem:  NewArticle) {
        detailImage.loadImage(imageURL: newsItem.imgUrl ?? "")
        sourceLabel.text = newsItem.source ?? ""
        titleLabel.text = newsItem.title ?? ""
    }
    
    private func autoLayout() {
        [sourceLabel, titleLabel, detailImage].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
            NSLayoutConstraint.activate([
                detailImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                detailImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                detailImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                detailImage.heightAnchor.constraint(equalToConstant: 200),
                
                sourceLabel.topAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: 8),
                sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                
                titleLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 8),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
                
                
                
                ])
    }
}
