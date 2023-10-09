//
//  AnimatedLaunchScreen.swift
//  SportsProject
//
//  Created by Hend on 03/10/2023.
//


import UIKit
import Lottie

class AnimatedLaunchScreen: UIViewController {
    private var animationView: LottieAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewControllers = self.navigationController?.viewControllers {
            print("Current View Controllers in Stack: \(viewControllers)")
            
        }
        view.backgroundColor = .white
        // 2. Start LottieAnimationView with animation name (without extension)
         
         animationView = .init(name: "Sports")
         
         animationView!.frame = view.bounds
         
         // 3. Set animation content mode
         
         animationView!.contentMode = .scaleAspectFit
         
         // 4. Set animation loop mode
         
         animationView!.loopMode = .playOnce
         
         // 5. Adjust animation speed
         
        // animationView!.animationSpeed = 1.9
         
         view.addSubview(animationView!)
         
         // 6. Play animation
         
         animationView!.play()
        
       // Timer.scheduledTimer(timeInterval: 4.3 , target: self, selector: #selector(MainNav), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 3 , target: self, selector: #selector(MainNav), userInfo: nil, repeats: false)
        
    }
    
    @objc func MainNav() {
        let homeTabBarController = HomeTabBarController()
        navigationController?.setViewControllers([homeTabBarController], animated: true)
    }

}
