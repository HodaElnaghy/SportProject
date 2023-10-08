//
//  HomeTabBarController.swift
//  SportsProject
//
//  Created by Hend on 03/10/2023.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeController = HomeViewController()
        let favoriteController = FavoriteLeaguesViewController()
        
        homeController.title = "home"
        favoriteController.title = "Favorites"
        
        let homeNavController = UINavigationController(rootViewController: homeController)
        let favoriteNavController = UINavigationController(rootViewController: favoriteController)
        
        // Set the view controllers for the tab bar controller
        self.setViewControllers([homeNavController, favoriteNavController], animated: true)
        
        guard let items = self.tabBar.items else {return}
        let images = ["football", "heart"]
        
        for i in 0...1 {
            items[i].image = UIImage(systemName: images[i])
        }
        self.tabBar.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setNeedsLayout()
        navigationController?.isNavigationBarHidden = true
    }
}
