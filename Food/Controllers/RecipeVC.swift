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
    private var recipe: RecipeModel!
    
    private let TopHStack = UIStackView()
    private let labelHStack = UIStackView()
    private let Vstack = UIStackView()

    private let titleLabel = UILabel()
    
    private let HealthScoreLabel = UILabel()
    private let ServingLabel = UILabel()
    private let priceLabel = UILabel()
    private let vegetarianLabel = UILabel()
    private let glutenFreeLabel = UILabel()
    
    private let foodImage = UIImageView()
    
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
            self.HealthScoreLabel.text = "Healt Score:\(String(describing: self.recipe.healthScore))"
            self.ServingLabel.text = "Serving:\(String(describing: self.recipe.servings))"
            self.priceLabel.text = "Price Per Service:\(String(describing: self.recipe.pricePerServing))"
            self.updateBoolLabel(label: self.vegetarianLabel, value: self.recipe.vegetarian, text: "Vegetarian:")
            self.updateBoolLabel(label: self.glutenFreeLabel, value: self.recipe.glutenFree, text: "Gluten:")
            self.foodImage.sd_setImage(with: URL(string: self.recipe.image)) { image, error, cacheType, url in
                if error != nil {
                    self.foodImage.image = UIImage(systemName: "photo")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchRecipe(id: foodId)
        style()
        layout()
        
    }
    
    private func updateBoolLabel(label: UILabel, value: Bool, text: String) {
        let labelValue = value ? "\(text) ✅" : "\(text) ❌"
        label.text = labelValue
    }
    
    private func style() {
        
        view.backgroundColor = .white
        self.navigationItem.title = "Recipe👨‍🍳"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodImage.image = UIImage(named: "images")
        foodImage.contentMode = .scaleAspectFit
        
        TopHStack.translatesAutoresizingMaskIntoConstraints = false
        TopHStack.axis = .horizontal
        TopHStack.alignment = .leading
        TopHStack.spacing = 10
        TopHStack.backgroundColor = UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)
        TopHStack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 1, right: 16)
        TopHStack.isLayoutMarginsRelativeArrangement = true
        
        labelHStack.translatesAutoresizingMaskIntoConstraints = false
        labelHStack.axis = .horizontal
        labelHStack.distribution = .fillEqually
        labelHStack.spacing = 3
        labelHStack.layoutMargins = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        TopHStack.isLayoutMarginsRelativeArrangement = true
        
        Vstack.translatesAutoresizingMaskIntoConstraints = false
        Vstack.axis = .vertical
        Vstack.alignment = .center
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.numberOfLines = 0
        
        HealthScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        HealthScoreLabel.textColor = UIColor.systemGray
        HealthScoreLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        HealthScoreLabel.numberOfLines = 0
        
        ServingLabel.translatesAutoresizingMaskIntoConstraints = false
        ServingLabel.textColor = UIColor.systemGray
        ServingLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        ServingLabel.numberOfLines = 0

        vegetarianLabel.translatesAutoresizingMaskIntoConstraints = false
        vegetarianLabel.textColor = UIColor.systemGray
        vegetarianLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        vegetarianLabel.numberOfLines = 0

    }
    
    private func layout() {
        
        view.addSubview(TopHStack)
        view.addSubview(labelHStack)
        view.addSubview(Vstack)
        
        labelHStack.addArrangedSubview(HealthScoreLabel)
        labelHStack.addArrangedSubview(ServingLabel)
        labelHStack.addArrangedSubview(vegetarianLabel)
        
        TopHStack.addArrangedSubview(foodImage)
        TopHStack.addArrangedSubview(titleLabel)


        NSLayoutConstraint.activate([
            TopHStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            TopHStack.widthAnchor.constraint(equalToConstant: view.frame.width),
            TopHStack.heightAnchor.constraint(equalToConstant: view.frame.height / 4),
            
            labelHStack.topAnchor.constraint(equalTo: TopHStack.bottomAnchor),
            labelHStack.widthAnchor.constraint(equalToConstant: view.frame.width),

            foodImage.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            foodImage.heightAnchor.constraint(equalToConstant: view.frame.height / 1.2),

            titleLabel.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: TopHStack.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: TopHStack.bottomAnchor, constant: -16),

            Vstack.topAnchor.constraint(equalToSystemSpacingBelow: TopHStack.bottomAnchor, multiplier: 2),
            Vstack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Vstack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            Vstack.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: -2),
        ])
    }

}
