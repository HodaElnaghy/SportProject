//
//  HomeTabBarController.swift
//  SportsProject
//
//  Created by Hend on 03/10/2023.
//

import Foundation
import UIKit

class HomeTabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.isHidden = true
        let homeController = HomeViewController()
        let favoriteController = FavoriteLeaguesViewController()
        
        
        homeController.title = "home"
        favoriteController.title = "Favorites"
        
        self.setViewControllers([homeController, favoriteController], animated: true)
        guard let items = self.tabBar.items else {return}
        let images = ["football", "heart"]
        
        for i in 0...1 {
            items[i].image = UIImage(systemName: images[i])
        }
        self.tabBar.backgroundColor = .white
    }
}
