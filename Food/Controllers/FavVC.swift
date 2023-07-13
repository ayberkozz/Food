//
//  FavVC.swift
//  Food
//
//  Created by Ayberk Öz on 11.07.2023.
//

import UIKit

class FavVC: UIViewController, FavListVMOutput{
    
    private let viewModel: FavListViewModel
    private var recipe: RecipeModel!
    private let userViewModel = UserViewModel(UserService: UserService())
    
    private var favCV : UICollectionView!
    private var FavList = [String]()
    
    init(viewModel: FavListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(recipeUpdate: RecipeModel) {
        self.recipe = recipeUpdate
    }
    
    func updateFavs(value: FavListModel) {
        self.FavList = value.favs
        favCV.reloadData()
    }
    
    func updateRecipe(recipe: RecipeModel, at indexPath: IndexPath) {
        DispatchQueue.main.async {
            guard let cell = self.favCV.cellForItem(at: indexPath) as? favCVC else {
                return
            }
            
            cell.configure(with: recipe)
        }
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userViewModel.fetchUser()
        viewModel.fetchFavList()
        style()
        layout()
        
    }
    
    private func fetchRecipeForCell(withID id: String, at indexPath: IndexPath) {
        viewModel.output = self
        if let recipeID = Int(id) {
            viewModel.fetchRecipe(id: recipeID, indexPath: indexPath)
        }
    }
    
    private func style() {
        view.backgroundColor = .white
        
        self.navigationItem.title = "Favorites❤️"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        favCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        favCV.translatesAutoresizingMaskIntoConstraints = false
        favCV.register(favCVC.self, forCellWithReuseIdentifier: favCVC.identifier)
        favCV.delegate = self
        favCV.dataSource = self
        favCV.backgroundColor = .systemBackground
        
    }
    
    private func layout() {
        
        view.addSubview(favCV)
        
        NSLayoutConstraint.activate([
          
            favCV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favCV.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            favCV.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            favCV.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favCV.heightAnchor.constraint(equalToConstant: view.frame.height)
            
        ])
        
    }

}

extension FavVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favCVC.identifier, for: indexPath) as! favCVC
        fetchRecipeForCell(withID: FavList[indexPath.row], at: indexPath)
//        if let recipe = recipe {
//            cell.configure(with: recipe)
//        } else {
//            cell.prepareForReuse()
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/1.5, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
