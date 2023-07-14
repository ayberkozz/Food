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
    
    enum HomeCVDetails: String, CaseIterable {
        case Random = "Get Random Recipe🪄"
        case search = "Search Foods🔎"
        case ingredients = "Search Foods By Ingredients🍴"
        
        var imageName: String {
            switch self {
            case .Random:
                return "exFood1"
            case .search:
                return "exFood2"
            case .ingredients:
                return "exFood3"
            }
        }
        
        var titleDescription : String {
            switch self {
            case .Random:
                return "Get a random recipe suggestion to discover new and exciting dishes."
            case .search:
                return "Search for specific foods based on your dietary preferences and nutritional requirements."
            case .ingredients:
                return "Search for recipes or food options based on the ingredients you have on hand."
            }
        }
    }
    
    private var HomeCV : UICollectionView!
    
    weak var delegate: HomeVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
    }
    
    @objc func openSideMenu() {
        delegate?.openSideMenu()
    }
    
    private func handleRandomRecipeAction() {
    }

    private func handleSearchFoodsAction() {
        let foodService: FoodServiceProtocol = FoodService()
        let viewModel = FoodViewModel(foodService: foodService)
        let foodMainVC = FoodMainVC(viewModel: viewModel)
        self.navigationController?.pushViewController(foodMainVC, animated: true)
    }

    private func handleSearchByIngredientsAction() {
        self.navigationController?.pushViewController(IngredientsVC(), animated: true)
    }
    
    private func style() {
        
        view.backgroundColor = .white
        
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        let sideMenuButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(openSideMenu))
        navigationItem.leftBarButtonItem = sideMenuButton
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        HomeCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        HomeCV.translatesAutoresizingMaskIntoConstraints = false
        HomeCV.dataSource = self
        HomeCV.delegate = self
        HomeCV.register(HomeCVC.self, forCellWithReuseIdentifier: HomeCVC.identifier)
        HomeCV.backgroundColor = .systemBackground
        HomeCV.showsVerticalScrollIndicator = false
        
    }

    private func layout() {
        
        view.addSubview(HomeCV)
        
        NSLayoutConstraint.activate([
            HomeCV.widthAnchor.constraint(equalToConstant: view.frame.width),
            HomeCV.heightAnchor.constraint(equalToConstant: view.frame.height),
        ])

    }
}

extension HomeVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCVC.identifier, for: indexPath) as! HomeCVC
        let details = HomeCVDetails.allCases[indexPath.row]
        let image = UIImage(named: details.imageName)
        cell.configure(with: image, title: details.rawValue, description: details.titleDescription)
        cell.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/1.1, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            handleRandomRecipeAction()
        case 1:
            handleSearchFoodsAction()
        case 2:
            handleSearchByIngredientsAction()
        default:
            break
        }
    }
    
}

