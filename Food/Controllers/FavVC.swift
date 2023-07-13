//
//  FavVC.swift
//  Food
//
//  Created by Ayberk Öz on 11.07.2023.
//

import UIKit

class FavVC: UIViewController, RecipeViewModelOutput{
    
    private let viewModel: RecipeViewModel
    private var recipe: RecipeModel!
    private let userViewModel = UserViewModel(UserService: UserService())
    
    private var favCV : UICollectionView!
    private var FavList = [String]()
    
    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(value: RecipeModel) {
        self.recipe = value
    }
    
    func updateFavList(value: FavListModel) {
        self.FavList = value.favs
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
    }
    
    private func style() {
        view.backgroundColor = .white
        
        
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favCVC.identifier, for: indexPath) as! favCVC
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/1.5, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
