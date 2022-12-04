//
//  SceneDelegate.swift
//  Minance
//
//  Created by Soyombo Mantaagiin on 28.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = createTabbar()
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func createExchangeViewController() -> UINavigationController {
        let exchangeVC = ExchangeViewController()
        exchangeVC.title = "Market"
        exchangeVC.tabBarItem = UITabBarItem(title: "Market", image: UIImage(systemName: "bitcoinsign.circle"), tag: 0)
        let exchangeNC = UINavigationController(rootViewController: exchangeVC)
        exchangeNC.navigationBar.prefersLargeTitles = true
        
        return exchangeNC
    }
    
    func createHomeViewController() -> UINavigationController {
        let homeVC = HomeViewController()
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        let homeNC = UINavigationController(rootViewController: homeVC)
        homeNC.navigationBar.prefersLargeTitles = true
        
        return homeNC
    }
    
    func createSavedViewController() -> UINavigationController {
        let savedVC = SavedViewController()
        savedVC.title = "Portfolio"
        savedVC.tabBarItem = UITabBarItem(title: "Portfolio", image: UIImage(systemName: "magazine"), tag: 2)
        let savedNC = UINavigationController(rootViewController: savedVC)
        savedNC.navigationBar.prefersLargeTitles = true
        
        return savedNC
    }

    func createTabbar() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = .systemBlue
        tabBar.viewControllers = [createExchangeViewController(),createHomeViewController(), createSavedViewController()]
        
        return tabBar
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

