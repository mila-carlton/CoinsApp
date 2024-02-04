//
//  DetailsTableViewCell.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 02.02.24.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    static let id = "\(DetailsTableViewCell.self)"
    
    var sourceUrl: String?
    
    private let sourceLabel = UILabel()
    private let titleLabel = UILabel()
    private let detailImage = UIImageView()
    
    private lazy var safariButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open in Safari", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(openInSafari), for: .touchUpInside)
        return button
    }()


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
        contentView.addSubview(safariButton)
        
        titleLabel.numberOfLines = 0
        sourceLabel.numberOfLines = 0
        backgroundColor = .clear
        detailImage.contentMode = .scaleAspectFit
    
    }
    
    @objc
    private func openInSafari() {
        if let url = URL(string: sourceUrl ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    func configure(newsItem:  NewArticle) {
        detailImage.loadImage(imageURL: newsItem.imgUrl ?? "")
        sourceLabel.text = newsItem.source ?? ""
        titleLabel.text = newsItem.title ?? ""
        
    }
    
    private func autoLayout() {
        [sourceLabel, titleLabel, detailImage, safariButton].forEach { view in
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
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                
                safariButton.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 64),
                safariButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                safariButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                safariButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                safariButton.heightAnchor.constraint(equalToConstant: 50)
                ])
    }
}
