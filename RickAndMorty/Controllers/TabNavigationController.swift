//
//  TabNavigationController.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 24.01.2025.
//

import UIKit

final class TabNavigationController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let charactersNavigationController = UINavigationController(rootViewController: CharactersViewController())
        let locationsNavigationController = UINavigationController(rootViewController: LocationsViewController())
        let episodesNavigationController = UINavigationController(rootViewController: EpisodesViewController())
        let settingsNavigationController = UINavigationController(rootViewController: SettingsViewController())
        
        let viewControllers = [charactersNavigationController, locationsNavigationController, episodesNavigationController, settingsNavigationController]
        let viewControllersIcons = ["person","globe","tv","gear"]
        let viewControllersTitle = ["Characters","Locations","Episodes","Settings"]
        
        for (index, viewController) in viewControllers.enumerated() {
            viewController.navigationBar.prefersLargeTitles = true
            viewController.tabBarItem = UITabBarItem(title: viewControllersTitle[index], image: UIImage(systemName: viewControllersIcons[index]), tag:index)
        }
        
        setViewControllers(viewControllers, animated: true)
    }
}
