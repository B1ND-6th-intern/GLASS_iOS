//
//  TabBarController.swift
//  GLASS_iOS
//
//  Created by DGSW on 2021/10/05.
//

import UIKit

final class tabBarcontroller: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        feedViewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let searchViewController = UINavigationController(rootViewController: PopularViewController())
        searchViewController.tabBarItem = UITabBarItem(
            title: "인기글",
            image: UIImage(systemName: "flame"),
            selectedImage: UIImage(systemName: "flame.fill")
        )
        
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem = UITabBarItem(
            title: "프로필",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        viewControllers = [feedViewController, searchViewController, profileViewController]
    }
}
