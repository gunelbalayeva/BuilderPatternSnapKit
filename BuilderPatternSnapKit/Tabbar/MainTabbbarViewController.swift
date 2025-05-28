//
//  MainTabbbarViewController.swift
//  BuilderPatternSnapKit
//
//  Created by User on 27.05.25.
//
import UIKit

final class MainTabBarController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    
    private func setupTabBar() {
        viewControllers = [
            createNavController(
                viewController: BarNameViewController(),
                title: "Bar Name",
                image: UIImage(named: "home")
            ),
            createNavController(
                viewController: SifarislerViewController(),
                title: "Sifarişlər",
                image: UIImage(named: "sifarisler")
            ),
            createNavController(
                viewController: BeyannameViewController(),
                title: "Bəyannamə",
                image: UIImage(named: "beyanname")
            ),
            createNavController(
                viewController: BalansViewController(),
                title: "Balans",
                image: UIImage(named: "balans")
            ),
            createNavController(
                viewController: MenyuViewController(),
                title: "Menyu",
                image: UIImage(named: "menyu")
            )
        ]
        selectedIndex = 1
        tabBar.tintColor = UIColor(named: "bg")
        tabBar.unselectedItemTintColor = .gray
    }
    
    private func createNavController(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem = UITabBarItem(title: title, image: image?.withRenderingMode(.alwaysTemplate), tag: 0)
        viewController.navigationItem.title = title
        return nav
    }
}
