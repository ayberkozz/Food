//
//  SideMenuVC.swift
//  Food
//
//  Created by Ayberk Öz on 9.07.2023.
//

import UIKit

class SideMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum MenuOptions: String, CaseIterable {
        case Favorites = "Favorites"
        case logout = "Log Out"
        
        var imageName: String {
            switch self {
            case .Favorites:
                return "heart.fill"
            case .logout:
                return "arrowshape.left.fill"
            }
        }
    }
    
    private let tv = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
        style()
        layout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = UIColor.white
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.tintColor = UIColor.white
        cell.backgroundColor = .systemGreen
        return cell
    }

    private func style() {
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = .systemGreen
        
    }
    
    private func layout() {
        view.addSubview(tv)
        
        NSLayoutConstraint.activate([
            tv.widthAnchor.constraint(equalToConstant: view.frame.width),
            tv.topAnchor.constraint(equalTo: view.centerYAnchor),
            tv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
