//
//  ViewController.swift
//  CoinsApp
//
//  Created by PASGON TEXTILE on 23.01.24.
//

import UIKit

final class MainTabBarController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        generateTabBar()
        configure()
    }
    
    private func generateTabBar() {
        viewControllers = [
        generateVC(viewController: CoinsViewController(), title: "Coins", image: UIImage(systemName: "folder.fill")!),
        generateVC(viewController: ExchangesViewController(), title: "Exchanges", image: UIImage(systemName: "arrow.left.arrow.right.square")!),
        generateVC(viewController: NewsViewController(), title: "News", image: UIImage(systemName: "newspaper.fill")!),
        generateVC(viewController: CurrencyViewController(), title: "Currencies", image: UIImage(systemName: "chart.bar.xaxis")!)
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let nav = UINavigationController(rootViewController: viewController)
        return nav
    }
    
    private func configure() {
        tabBar.backgroundColor = .white
        tabBar.layer.borderWidth = 1
        
    }
    
}

