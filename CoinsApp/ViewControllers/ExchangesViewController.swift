//
//  ExchangesViewController.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 23.01.24.
//

import UIKit

final class ExchangesViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var exchs: [Exchange] = []
    private let webService = WebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.backgroundColor = .customBackgroundColor
        setupCollectionView()
        fetchExch()
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        title = "Exchanges"
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
    }
    
    func fetchExch() {
        
        webService.fetchExchanges { [weak self] exchanges in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.exchs = exchanges ?? []
                self.collectionView.reloadData()
            }
            
        }
    }
}

extension ExchangesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        exchs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .cellColor
        let exchange = exchs[indexPath.row]
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        let label = UILabel(frame: cell.bounds)
        label.text = "  " + (exchange.name ?? "")
        label.textAlignment = .left
        
        cell.contentView.addSubview(label)
        cell.backgroundColor = .cellColor
        cell.layer.cornerRadius = 10
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.bounds.width - 30), height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}
