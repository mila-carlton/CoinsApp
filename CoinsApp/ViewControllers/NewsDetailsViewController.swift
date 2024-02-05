//
//  NewsDetailsViewController.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 02.02.24.
//

import UIKit

final class NewsDetailsViewController: UIViewController {
    
    let tableView = UITableView()
    
    var news: NewArticle
    var sourceUrl: String?
    
    init(news: NewArticle) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var safariButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open in Safari", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(openInSafari), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        autoLayout()
        view.backgroundColor = .customBackgroundColor
    }
    
    @objc
    private func openInSafari() {
        sourceUrl = news.sourceLink
        if let url = URL(string: sourceUrl ?? "") {
            UIApplication.shared.open(url)
        }
    }
    
    private func setupTableView() {
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.id)
        view.addSubview(tableView)
        view.addSubview(safariButton)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
    }
    private func autoLayout() {
        [tableView, safariButton].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            safariButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            safariButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            safariButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            safariButton.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension NewsDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.id, for: indexPath) as! DetailsTableViewCell
        cell.configure(newsItem: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
