//
//  SideMenuContainerVC.swift
//  Food
//
//  Created by Ayberk Öz on 9.07.2023.
//

import UIKit

class SideMenuContainerVC: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let sideMenuVC = SideMenuVC()
    let homeVC = HomeVC()
    var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildsVCs()
    }
    
    private func addChildsVCs() {
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
    
}

extension SideMenuContainerVC : HomeVCDelegate {
    
    func openSideMenu() {
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
                }
            }
            
        }
    }
    
}

