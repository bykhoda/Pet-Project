//
//  MainTabBarController.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
        setTabBarAppearance()
    }
    
    private func setTabBarAppearance() {
        tabBar.tintColor = UIColor.red
        tabBar.unselectedItemTintColor = UIColor.black
        tabBar.backgroundColor = UIColor.white
    }
    
    private func generateNavigationController(viewController: UIViewController, imageName: String, tag: Int) -> UINavigationController {
        let tabBarImage = UIImage(systemName: imageName)
        viewController.tabBarItem = UITabBarItem(title: nil, image: tabBarImage, tag: tag)
        return UINavigationController(rootViewController: viewController)
    }
    
    private func createTabBar() {
        
        let postVC = DependencyManager.shared.buildPostModule()
        let postNVC = generateNavigationController(viewController: postVC, imageName: "house", tag: 0)
        let searchNVC = generateNavigationController(viewController: SearchViewController(), imageName: "magnifyingglass", tag: 1)
        let chatNVC = generateNavigationController(viewController: ChatViewController(), imageName: "ellipsis.bubble", tag: 2)
        let notificationsNVC = generateNavigationController(viewController: NotificationsViewController(), imageName: "bell", tag: 3)
        let profileNVC = generateNavigationController(viewController: ProfileViewController(), imageName: "person", tag: 3)
        let viewControllers = [postNVC, searchNVC, chatNVC, notificationsNVC, profileNVC]
        self.setViewControllers(viewControllers, animated: true)
    }
    
}
