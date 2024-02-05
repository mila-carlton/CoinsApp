//
//  MarketViewCell.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 31.01.24.
//

import UIKit

final class MarketCollectionViewCell: UICollectionViewCell {
    
    static let id = "\(MarketCollectionViewCell.self)"
    
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
        backgroundColor = UIColor.cellColor //UIColor(red: 238/255, green: 236/255, blue: 240/255, alpha: 1)
        layer.cornerRadius = 15
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(marketLabel)
    }
    
    func configure(market: Market) {
        titleLabel.text = market.pair ?? ""
        priceLabel.text = market.price?.rounding() ?? ""
        marketLabel.text = market.exchange ?? ""
        
        titleLabel.font = .boldSystemFont(ofSize: 10)
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
            
            marketLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 15),
            marketLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
