//
//  TabBarViewController.swift
//  TrackerPracticum
//
//  Created by Alexander Farizanov on 09.05.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationController = UINavigationController(rootViewController: TrackerViewController())
        
        navigationController.tabBarItem = UITabBarItem(title: "Трекер", image: UIImage(named: "barItemTracker"), selectedImage: nil)
        
        let statisticsViewController = StatisticsViewController()
        
        statisticsViewController.tabBarItem = UITabBarItem(title: "Статистика", image: UIImage(named: "barItemStatistics"), selectedImage: nil)
        
        self.viewControllers = [navigationController, statisticsViewController]
    }
    

}
