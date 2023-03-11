//
//  ViewController.swift
//  MoviesClone
//
//  Created by mona alshiakh on 08/04/1444 AH.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray
        
        // assigning the VCs
        let v1 = UINavigationController(rootViewController: HomeVC())
        let v2 = UINavigationController(rootViewController: UpcomingVC())
        let v3 = UINavigationController(rootViewController: SearchVC())
        let v4 = UINavigationController(rootViewController: DownloadsVC())
        
        // add tapbar icons image
        v1.tabBarItem.image = UIImage(systemName: "house")
        v2.tabBarItem.image = UIImage(systemName: "play.circle")
        v3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        v4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        // add title to tabbar icone
        v1.title = "Home"
        v2.title = "Coming Soon"
        v3.title = "Top Search"
        v4.title = "Downloads"
        
        //change the taint for both light or dark mode
        tabBar.tintColor = .label
        
        // show the VCs on the screen
        setViewControllers([v1, v2, v3, v4], animated: true)
    }


}

