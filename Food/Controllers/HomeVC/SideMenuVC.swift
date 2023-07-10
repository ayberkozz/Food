//
//  SideMenuVC.swift
//  Food
//
//  Created by Ayberk Öz on 9.07.2023.
//

import UIKit
import Firebase

protocol SideMenuDelegate : AnyObject {
    func didSelect(menuItem : SideMenuVC.MenuOptions)
}

class SideMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UserViewModelOutput {
    
    weak var delegate: SideMenuDelegate?
    
    enum MenuOptions: String, CaseIterable {
        case Favorites = "Favorites"
        case shareApp = "Share App"
        case logout = "Log Out"
        
        var imageName: String {
            switch self {
            case .Favorites:
                return "heart.fill"
            case .logout:
                return "arrowshape.left.fill"
            case .shareApp:
                return "square.and.arrow.up.fill"
            }
        }
    }
    
    private let viewModel : UserViewModel
    private var User: AuthModel!
    
    private let userVstack = UIStackView()
    private let UsernameLabel = UILabel()
    private let emailLabel = UILabel()
    private let tv = UITableView()
    

    let fireStoreDatabase = Firestore.firestore()
    
    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(value: AuthModel) {
        self.User = value
        DispatchQueue.main.async {
            self.UsernameLabel.text = self.User.username
            self.emailLabel.text = self.User.email
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchUser()
        
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
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }

    private func style() {
        view.backgroundColor = UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)
        tv.separatorStyle = .none
        
        userVstack.translatesAutoresizingMaskIntoConstraints = false
        userVstack.axis = .vertical
        userVstack.alignment = .leading
        userVstack.spacing = 3
        userVstack.isLayoutMarginsRelativeArrangement = true
        userVstack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        UsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        UsernameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        UsernameLabel.textColor = UIColor.white
        UsernameLabel.numberOfLines = 0
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        emailLabel.textColor = UIColor.white
        emailLabel.numberOfLines = 0
    }
    
    private func layout() {
        view.addSubview(userVstack)
        view.addSubview(tv)
        
        userVstack.addArrangedSubview(UsernameLabel)
        userVstack.addArrangedSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            userVstack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userVstack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            tv.widthAnchor.constraint(equalToConstant: view.frame.width),
            tv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tv.topAnchor.constraint(equalToSystemSpacingBelow: userVstack.bottomAnchor, multiplier: 5),
        ])
    }
    
//    private func getUserInfo() {
//        UserService.shared.getUserInfo { [weak self] result in
//            switch result {
//            case .success(let authModel):
//                DispatchQueue.main.async {
//                    self?.UsernameLabel.text = authModel.username
//                    self?.emailLabel.text = Auth.auth().currentUser?.email
//                }
//            case .failure(let error):
//                print("Failed to get user information: \(error.localizedDescription)")
//            }
//        }
//    }

}
