//
//  CoinViewCell.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 23.01.24.
//

import UIKit

class CoinViewCell: UITableViewCell {
    static let identifier = "CoinViewCell"
    
    var logoImage = UIImageView()
    let nameLabel = UILabel()
    let abbreviationLabel = UILabel()
    let valueLabel = UILabel()
    let changeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(logoImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(abbreviationLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(changeLabel)
    }
    
    func autoLayout() {
        [logoImage, nameLabel, abbreviationLabel, valueLabel, changeLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
            NSLayoutConstraint.activate([
                logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                logoImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                logoImage.widthAnchor.constraint(equalToConstant: 32),
                logoImage.heightAnchor.constraint(equalToConstant: 32),
                
                nameLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 8),
                nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                
                abbreviationLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 8),
                abbreviationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                
                valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                
                changeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                changeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
            ])
        }
        
        func configure(coin: Coin) {
            let cell = self.defaultContentConfiguration()
            nameLabel.text = coin.name
            abbreviationLabel.text = coin.symbol
            valueLabel.text = "$ \(coin.price)"
            changeLabel.text = "\(coin.priceChange1d)"
            NetworkManager.shared.fetchImage(from: coin.icon) { data in
                DispatchQueue.main.async { [unowned self] in
                    logoImage.image = UIImage(data: data)
                    self.contentConfiguration = cell
                }
            }
            self.contentConfiguration = cell
        }
    }
