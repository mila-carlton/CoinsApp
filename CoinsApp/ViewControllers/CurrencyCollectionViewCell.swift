//
//  CurrencyCollectionViewCell.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 01.02.24.
//

import UIKit

final class CurrencyCollectionViewCell: UICollectionViewCell {
    static let id = "\(CurrencyCollectionViewCell.self)"
    
    var nameLabel = UILabel()
    var image = UIImageView()
    var priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = 15
        backgroundColor = .cellColor
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(image)
        contentView.addSubview(priceLabel)
    }
    
    private func autoLayout() {
        [nameLabel, image, priceLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            priceLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configure(currency: Currency) {
        nameLabel.text = currency.name ?? ""
        priceLabel.text = (currency.symbol ?? "") + String(describing: currency.rate?.rounded() ?? 0)
        nameLabel.font = .boldSystemFont(ofSize: 18)
        
        guard let imageView = currency.imageUrl else { return }
        image.loadImage(imageURL: imageView)
    }
}
