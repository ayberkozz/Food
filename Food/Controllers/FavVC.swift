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
    
    let cellWidth: CGFloat = 300
    let extraPad: CGFloat = 85/2
    
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
        setData()
        
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
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.largeTitleDisplayMode = .always
                
        let flowLayout = SnappingCollectionViewLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        favCV = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        favCV.translatesAutoresizingMaskIntoConstraints = false
        favCV.register(favCVC.self, forCellWithReuseIdentifier: favCVC.identifier)
        favCV.contentInset = UIEdgeInsets(top: 0, left: extraPad, bottom: 0, right: extraPad)
        favCV.delegate = self
        favCV.dataSource = self
        favCV.decelerationRate = UIScrollView.DecelerationRate.fast
        favCV.showsHorizontalScrollIndicator = false

    }
    
    private func layout() {
        
        view.addSubview(favCV)
        
        NSLayoutConstraint.activate([
          
            favCV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favCV.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            favCV.leadingAnchor.constraint(equalTo: view.leadingAnchor),
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
        cell.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        fetchRecipeForCell(withID: FavList[indexPath.row], at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: 500)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = RecipeViewModel(foodService: FoodService(), favListService: FavListService())
        let recipeVC = RecipeVC(viewModel: viewModel)
        recipeVC.foodId = Int(FavList[indexPath.row])!
        navigationController?.pushViewController(recipeVC, animated: true)
    }
    
}

extension FavVC {
    
    func setData() {
        let indexPath = IndexPath(row: 0, section: 0)
        DispatchQueue.main.async {
            self.favCV.scrollToItem(at: indexPath,
                                             at: .centeredHorizontally,
                                             animated: false)
            if indexPath.row == 0 {
                let cell = self.favCV.cellForItem(at: indexPath) as? favCVC
                cell?.containerView.transform = .identity
            }
        }
    }
    
    func checkOffsetValue(scrollView: UIScrollView) {
        let xOffset = scrollView.contentOffset.x + extraPad
        let curIndex = Int(xOffset/cellWidth)
        let nextIndex = curIndex + 1
        let offsetInCurrentContext = xOffset - CGFloat(curIndex) * cellWidth
        
        let value = (((offsetInCurrentContext / cellWidth) * 100 ) * 0.2 ) / 100

        let currentCell = favCV.cellForItem(at: IndexPath(row: curIndex, section: 0)) as? favCVC
        let nextCell = favCV.cellForItem(at: IndexPath(row: nextIndex, section: 0)) as? favCVC
        
        currentCell?.containerView.transform = CGAffineTransform(scaleX: 1 - value, y: 1 - value)
        nextCell?.containerView.transform = CGAffineTransform(scaleX: 0.8 + value, y: 0.8 + value)
    }
    
}

extension FavVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        checkOffsetValue(scrollView: scrollView)
    }
}

