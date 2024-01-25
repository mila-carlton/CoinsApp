//
//  ExchangesViewController.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 23.01.24.
//

import UIKit

final class ExchangesViewController: UIViewController {
    
    let tableView = UITableView()
    var exchs: [Exchange] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        fetchExch()
        setupTableView()
       
        
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func fetchExch() {
        NetworkManager.shared.fetchExchange(url: urlExch.absoluteString) {[unowned self] exchs in
            DispatchQueue.main.async {
                self.exchs = exchs
                self.tableView.reloadData()
            }
        }
    }

}
 
extension ExchangesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exchs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let exchange = exchs[indexPath.row]
        cell.textLabel?.text = exchange.name
        cell.backgroundColor = .gray
        return cell
    }
    
    
}
