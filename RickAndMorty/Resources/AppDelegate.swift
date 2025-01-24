//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Engin Bolat on 24.01.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

           window = UIWindow(frame: UIScreen.main.bounds)
           window?.rootViewController = TabNavigationController()
           window?.makeKeyAndVisible()

           return true
       }

}

