//
//  CurrenciesViewController.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 23.01.24.
//

import UIKit

final class CurrencyViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var currency: [Currency] = []
    private let webService = WebService()
    
    lazy var currencyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        title = "Currencies"
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: CurrencyCollectionViewCell.id)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBackgroundColor
        fetchCurrency()
    }
    
    private func fetchCurrency() {
        webService.fetchCurrency { [weak self] currency in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.currency = currency ?? []
                self.currencyCollectionView.reloadData()
            }
        }
    }
}

extension CurrencyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currency.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.id, for: indexPath) as? CurrencyCollectionViewCell else { return UICollectionViewCell() }
        let currency = currency[indexPath.row]
        cell.configure(currency: currency)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - 30) / 2
        let height: CGFloat = 140
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
}
