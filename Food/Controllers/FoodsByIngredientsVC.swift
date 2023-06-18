//
//  IngredientsVC.swift
//  Food
//
//  Created by Ayberk Öz on 15.06.2023.
//

import UIKit

class FoodsByIngredientsVC: UIViewController, FoodsByIngredientsViewModelOutput {
    
    private var foodCV : UICollectionView!
    
    private let viewModel : FoodsByIngredientsViewModel
    private lazy var foodsByIngredients : [FoodsByIngredientsModel] = []
    var ingredients : [String] = []
    
    init(viewModel: FoodsByIngredientsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(values: [FoodsByIngredientsModel]) {
        foodsByIngredients = values
        DispatchQueue.main.async {
            self.foodCV.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchFoodsByIngredients(query: ingredients, number: 2)
        
        style()
        layout()
    }
    
    func style() {
        
        view.backgroundColor = .white
        
        self.navigationItem.title = "Foods By Ingredients🥙"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        let layout = UICollectionViewFlowLayout()
        foodCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        foodCV.translatesAutoresizingMaskIntoConstraints = false
        foodCV.register(FoodsByIngredientsTVC.self, forCellWithReuseIdentifier: FoodsByIngredientsTVC.reuseIdentifier)
        foodCV.delegate = self
        foodCV.dataSource = self
        
    }
    
    func layout() {
        
        view.addSubview(foodCV)
        
        NSLayoutConstraint.activate([
            
            foodCV.topAnchor.constraint(equalTo: view.topAnchor),
            foodCV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            foodCV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            foodCV.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])

    }
    
}

//MARK: - Collection View
extension FoodsByIngredientsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodsByIngredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodsByIngredientsTVC.reuseIdentifier, for: indexPath) as! FoodsByIngredientsTVC
        let foods = viewModel.AllFoodsByIngredients[indexPath.row]
        cell.configure(with: foods)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2-20, height: 250)
    }
    
}




