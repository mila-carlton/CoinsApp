//
//  MarketViewController.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 31.01.24.
//

import UIKit


final class MarketViewController: UIViewController {
    
    var selectedCoin: Coin?
    private var markets = [Market]()
    private let webService = WebService()
    
    lazy var marketCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MarketCollectionViewCell.self, forCellWithReuseIdentifier: MarketCollectionViewCell.id)
        
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
        setupView()
        fetchMarkets()
    }
    
    func setupView() {
        view.backgroundColor = .customBackgroundColor//UIColor(red: 238/255, green: 236/255, blue: 240/255, alpha: 1.0)
        title = "Market"
    }
    
    private func fetchMarkets() {
        webService.fetchMarkets { [weak self] market in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.markets = market ?? []
                self.marketCollectionView.reloadData()
            }
        }
    }
}

    extension MarketViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            markets.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarketCollectionViewCell.id, for: indexPath) as? MarketCollectionViewCell else { return UICollectionViewCell() }
            let market = markets[indexPath.item]
            cell.configure(market: market)
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

