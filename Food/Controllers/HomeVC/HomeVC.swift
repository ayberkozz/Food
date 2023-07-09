//
//  HomeVC.swift
//  Food
//
//  Created by Ayberk Öz on 9.07.2023.
//

import UIKit

protocol HomeVCDelegate: AnyObject {
    func openSideMenu()
}

class HomeVC: UIViewController {
    
    weak var delegate: HomeVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
    }
    
    @objc func openSideMenu() {
        delegate?.openSideMenu()
    }
    
    private func style() {
        
        view.backgroundColor = .white
        
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        let sideMenuButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(openSideMenu))
        navigationItem.leftBarButtonItem = sideMenuButton
    }

    private func layout() {

    }
}
