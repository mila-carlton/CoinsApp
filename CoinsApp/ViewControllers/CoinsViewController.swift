//
//  CoinsViewController.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 23.01.24.
//

import UIKit

final class CoinsViewController: UIViewController {
    
    
    let tableView = UITableView()
    
    private var coins: [Coin] = []
    
    private let webService = WebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coins"
        setupTableView()
        view.backgroundColor = .customBackgroundColor
        fetchCoins()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(CoinViewCell.self, forCellReuseIdentifier: CoinViewCell.identifier)
        tableView.rowHeight = 72
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchCoins() {
        webService.fetchCoins { [weak self] coins  in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.coins = coins ?? []
                self.tableView.reloadData()
            }
        }
    }
    
}

extension CoinsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinViewCell.identifier, for: indexPath) as? CoinViewCell else { return UITableViewCell() }
        let coin = coins[indexPath.row]
        cell.configure(coin: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCoin = coins[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let marketVC = MarketViewController()
        marketVC.selectedCoin = selectedCoin
        navigationController?.show(marketVC, sender: self)
    }
}
