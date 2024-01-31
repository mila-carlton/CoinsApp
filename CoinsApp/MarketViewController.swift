//
//  MarketViewController.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 31.01.24.
//

import UIKit


class MarketViewController: UICollectionViewController {
    
    var selectedIndexPath: IndexPath?
    var markets = [Market]()
    private let webService = WebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MarketCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        setupView()
        fetchMarkets()
    }
    
    func setupView() {
        view.addSubview(collectionView)
        view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 238/255, alpha: 1.0)
        title = "Market"
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
    }
    
    private func fetchMarkets() {
        webService.fetchMarkets { [weak self] market in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.markets = market ?? []
                self.collectionView.reloadData()
            }
        }
    }
}

    extension MarketViewController: UICollectionViewDelegateFlowLayout {
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            markets.count
        }

        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketCell", for: indexPath) as? MarketViewCell else { return UICollectionViewCell() }
            let market = markets[indexPath.item]
            cell.configure(market: market)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let padding: CGFloat = 10
            let collectionViewSize = collectionView.frame.size.width - padding * 2
            let width = collectionViewSize/2
            let height: CGFloat = 80
            return CGSize(width: width, height: height)
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            10
        }
    }

