//
//  CoinViewCell.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 23.01.24.
//

import UIKit

class CoinViewCell: UITableViewCell {
    static let identifier = "\(CoinViewCell.self)"
    
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
    
    func configure(coin: Coin) {
        nameLabel.text = coin.name ?? "iooeieo"
        guard let icon = coin.icon else { return }
        logoImage.loadImage(imageURL: icon)
        abbreviationLabel.text = coin.symbol ?? ""
        valueLabel.text = "$ " + (coin.price?.rounding() ?? "")
        changeLabel.text = (coin.priceChange1d?.rounding() ?? "") + " %"
        valueLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.font = .boldSystemFont(ofSize: 20)
        
        if coin.priceChange1d ?? 0 > 0 {
            changeLabel.textColor = .green
        } else {
            changeLabel.textColor = .red
        }
    }
        
    private func addSubviews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        contentView.addSubview(logoImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(abbreviationLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(changeLabel)
        
    }
    
    private func autoLayout() {
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
    }



