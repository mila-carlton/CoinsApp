//
//  MarketViewCell.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 31.01.24.
//

import UIKit

class MarketViewCell: UICollectionViewCell {
    
    var titleLabel = UILabel()
    var priceLabel = UILabel()
    var marketLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(marketLabel)
    }
    
    private func autoLayout() {
        [titleLabel, priceLabel, marketLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                
                priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                
                marketLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15),
                marketLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
}
    
    func configure(market: Market) {
        titleLabel.text = market.pair ?? ""
        priceLabel.text = market.price?.rounding() ?? ""
        marketLabel.text = market.exchange ?? ""
        
        titleLabel.font = .boldSystemFont(ofSize: 10)
    }
            }
