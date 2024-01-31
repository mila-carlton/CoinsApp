//
//  CoinsViewController.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 23.01.24.
//

import UIKit

class CoinsViewController: UIViewController {
    

let tableView = UITableView()
    var coins: [Coin] = []
    
    private let webService = WebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coins"
        setupTableView()
        view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 238/255, alpha: 1.0)
        fetchCoins()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.register(CoinViewCell.self, forCellReuseIdentifier: CoinViewCell.identifier)
        tableView.rowHeight = 60
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
        let marketVC = MarketViewController()
//        marketVC.selectedIndexPath = indexPath
        let navVC = UINavigationController(rootViewController: marketVC)
        present(navVC, animated: true)
    }
    
}
