//
//  SceneDelegate.swift
//  Food
//
//  Created by Ayberk Öz on 9.06.2023.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let currentUser = Auth.auth().currentUser

        if currentUser != nil {
            setTabBarControllerAsRootViewController()
        } else {
            let authVC = AuthVC()
            let authNavigationController = UINavigationController(rootViewController: authVC)
            self.window?.rootViewController = authNavigationController
        }
        
        self.window?.makeKeyAndVisible()
    }

    
    func replaceRootViewController(with viewController: UIViewController) {
        if let window = window {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = viewController
            }, completion: nil)
        } else {
            print("Window is nil")
        }
    }
    
    func setTabBarControllerAsRootViewController() {
        
        let navigationController2 = UINavigationController(rootViewController: SideMenuContainerVC())
        
        navigationController2.tabBarItem = UITabBarItem(title: "Home ", image: UIImage(systemName: "house"), tag: 0)
        navigationController2.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)], for: .normal)
        navigationController2.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)], for: .selected)
        navigationController2.tabBarItem.image = UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal)
        navigationController2.tabBarItem.selectedImage = UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal)
        
        let foodService: FoodServiceProtocol = FoodService()
        let viewModel = FoodViewModel(foodService: foodService)
        let foodMainVC = FoodMainVC(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: foodMainVC)
        
        navigationController.tabBarItem = UITabBarItem(title: "Food", image: UIImage(systemName: "fork.knife"), tag: 0)
        navigationController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)], for: .normal)
        navigationController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)], for: .selected)
        navigationController.tabBarItem.image = UIImage(systemName: "fork.knife")?.withRenderingMode(.alwaysOriginal)
        navigationController.tabBarItem.selectedImage = UIImage(systemName: "fork.knife")?.withRenderingMode(.alwaysOriginal)
        
        let navigationController1 = UINavigationController(rootViewController: IngredientsVC())
        
        navigationController1.tabBarItem = UITabBarItem(title: "Ingredients ", image: UIImage(systemName: "carrot"), tag: 0)
        navigationController1.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)], for: .normal)
        navigationController1.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)], for: .selected)
        navigationController1.tabBarItem.image = UIImage(systemName: "carrot")?.withRenderingMode(.alwaysOriginal)
        navigationController1.tabBarItem.selectedImage = UIImage(systemName: "carrot")?.withRenderingMode(.alwaysOriginal)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationController2, navigationController, navigationController1]
        
        replaceRootViewController(with: tabBarController)
    }
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
}




