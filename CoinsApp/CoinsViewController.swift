//
//  CoinsViewController.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 23.01.24.
//

import UIKit

class CoinsViewController: UIViewController {
    

let tableView = UITableView()
    var coins = [Coin]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.register(CoinViewCell.self, forCellReuseIdentifier: "CoinViewCell")
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
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
    }
    
    private func fetchCoins() {
        NetworkManager.shared.fetchCoins(url: url.absoluteString) { [unowned self] coins in
            self.coins = coins
            tableView.reloadData()
        }
    }
    
}

extension CoinsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoinViewCell", for: indexPath) as? CoinViewCell else { return UITableViewCell() }
        let coin = coins[indexPath.row]
        cell.configure(coin: coin)
        return cell
    }
    
    
}
