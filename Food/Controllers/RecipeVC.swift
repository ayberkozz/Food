//
//  RecipeVC.swift
//  Food
//
//  Created by Ayberk Öz on 23.06.2023.
//

import UIKit
import SDWebImage

class RecipeVC: UIViewController, RecipeViewModelOutput {
    
    var foodId: Int = 0
    private let viewModel: RecipeViewModel
    private var recipe: RecipeModel?
    
    private let Vstack = UIStackView()
    private let titleLabel = UILabel()
    private let foodImage = UIImageView()
    private let RecipeLabel = UILabel()
    
    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(value: RecipeModel) {
        recipe = value
        DispatchQueue.main.async {
            self.titleLabel.text = self.recipe?.title
            self.RecipeLabel.text = self.recipe?.summary
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchRecipe(id: foodId)
        style()
        layout()
    }
    
    private func style() {
        
        view.backgroundColor = .white
        
        Vstack.translatesAutoresizingMaskIntoConstraints = false
        Vstack.axis = .vertical
        Vstack.alignment = .center
        Vstack.spacing = 3
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        
        RecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        RecipeLabel.textColor = .black
        RecipeLabel.numberOfLines = 0
        
    }
    
    private func layout() {
        
        view.addSubview(Vstack)
        
        Vstack.addArrangedSubview(titleLabel)
        Vstack.addArrangedSubview(RecipeLabel)
        
        NSLayoutConstraint.activate([
            Vstack.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            Vstack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Vstack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            Vstack.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -2),
        ])
        
    }
}
