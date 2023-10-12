//
//  SideMenuContainerVC.swift
//  Food
//
//  Created by Ayberk Öz on 9.07.2023.
//

import UIKit
import Firebase

class SideMenuContainerVC: UIViewController,AuthOutViewModelDelegate {
        
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let authViewModel = AuthViewModel()

    var userService: UserServiceProtocol!
    var viewModel: UserViewModel!
    var sideMenuVC: SideMenuVC!
    
    let homeVC = HomeVC()
    
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userService = UserService()
        viewModel = UserViewModel(UserService: userService)
        sideMenuVC = SideMenuVC(viewModel: viewModel)
        
        
        authViewModel.delegateOut = self
        addChildsVCs()
        
    }
    
    private func addChildsVCs() {
        sideMenuVC.delegate = self
        addChild(sideMenuVC)
        view.addSubview(sideMenuVC.view)
        sideMenuVC.didMove(toParent: self)

        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
    
    func didSignOutSuccessfully() {
        let authVC = AuthVC()
        authVC.modalPresentationStyle = .fullScreen
        present(authVC, animated: true, completion: nil)
    }
    
}

extension SideMenuContainerVC : HomeVCDelegate {
    
    func openSideMenu() {
        toggleMenu(completion: nil)
        tabBarController?.tabBar.isHidden = true
    }
    
    func toggleMenu(completion: (() -> Void )?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width/2 + 20
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    self?.tabBarController?.tabBar.isHidden = false
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
            
        }
    }
}

extension SideMenuContainerVC: SideMenuDelegate {
    
    func didSelect(menuItem: SideMenuVC.MenuOptions) {
        openSideMenu()
        toggleMenu { [weak self] in
            switch menuItem {
            case .Favorites:
                let favVC = FavVC(viewModel: FavListViewModel(foodService: FoodService(), favListService: FavListService())) 
                self?.navigationController?.pushViewController(favVC, animated: true)
            case .shareApp:
                break
            case .logout:
                self?.authViewModel.logOut()
            }
        }
    }
    
}

