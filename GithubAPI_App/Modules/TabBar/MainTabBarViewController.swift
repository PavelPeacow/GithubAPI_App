//
//  MainTabBarViewController.swift
//  GithubAPI_App
//
//  Created by Павел Кай on 19.11.2022.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let profile = UINavigationController(rootViewController: LoginViewController())
        let search = UINavigationController(rootViewController: SearchViewController())
        
        profile.tabBarItem.title = "Profile"
        search.tabBarItem.title = "RepoViewer"
        
        profile.tabBarItem.image = UIImage(systemName: "person.circle")
        search.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        setViewControllers([search, profile], animated: true)
    }
}
