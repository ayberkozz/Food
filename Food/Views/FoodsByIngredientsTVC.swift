//
//  IngredientsTVC.swift
//  Food
//
//  Created by Ayberk Öz on 15.06.2023.
//

import UIKit

class FoodsByIngredientsTVC: UICollectionViewCell {
    
    static let reuseIdentifier = "IngredientsTVCIdentifier"
    private(set) var food : FoodsByIngredientsModel!
    
    private let Vstack : UIStackView = {
        let Vstack = UIStackView()
        Vstack.axis = .vertical
        Vstack.spacing = 10
        Vstack.alignment = .leading
        return Vstack
    }()
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private let usedIngredientsCount : UILabel = {
        let usedIngredients = UILabel()
        usedIngredients.textColor = .white
        usedIngredients.textAlignment = .left
        usedIngredients.font = .systemFont(ofSize: 18, weight: .semibold)
        usedIngredients.numberOfLines = 0
        return usedIngredients
    }()
    
    private let UnusedIngredientsCount : UILabel = {
        let UnusedIngredientsCount = UILabel()
        UnusedIngredientsCount.textColor = .white
        UnusedIngredientsCount.textAlignment = .left
        UnusedIngredientsCount.font = .systemFont(ofSize: 18, weight: .semibold)
        UnusedIngredientsCount.numberOfLines = 0
        return UnusedIngredientsCount
    }()
    
    private let likeCount : UILabel = {
        let likeCount = UILabel()
        likeCount.textColor = .white
        likeCount.textAlignment = .left
        likeCount.font = .systemFont(ofSize: 18, weight: .semibold)
        likeCount.numberOfLines = 0
        return likeCount
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 20
    }
    
    
    func layout() {
        contentView.backgroundColor = UIColor.systemGreen
        contentView.addSubview(Vstack)
        
        Vstack.addArrangedSubview(nameLabel)
        Vstack.addArrangedSubview(usedIngredientsCount)
        Vstack.addArrangedSubview(UnusedIngredientsCount)
        Vstack.addArrangedSubview(likeCount)

        Vstack.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        usedIngredientsCount.translatesAutoresizingMaskIntoConstraints = false
        UnusedIngredientsCount.translatesAutoresizingMaskIntoConstraints = false
        likeCount.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            Vstack.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            Vstack.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            Vstack.trailingAnchor.constraint(equalToSystemSpacingAfter: contentView.trailingAnchor, multiplier: -1)
            
        ])
    }


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with food: FoodsByIngredientsModel) {
        self.food = food
        self.nameLabel.text = food.title
        self.usedIngredientsCount.text = "✅Used Ingredients Count:\(food.usedIngredientCount)"
        self.UnusedIngredientsCount.text = "❌Unused Ingredients Count:\(food.missedIngredientCount)"
        self.likeCount.text = "👍🏻\(food.likes)"
    }
    
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.usedIngredientsCount.text = nil
        self.UnusedIngredientsCount.text = nil
        self.likeCount.text = nil
    }
}

