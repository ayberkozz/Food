//
//  IngredientsTVC.swift
//  Food
//
//  Created by Ayberk Öz on 15.06.2023.
//

import UIKit
import SDWebImage

class FoodsByIngredientsCVC: UICollectionViewCell {
    
    static let reuseIdentifier = "IngredientsCVCIdentifier"
    private(set) var food : FoodsByIngredientsModel!
    
    private let Vstack : UIStackView = {
        let Vstack = UIStackView()
        Vstack.axis = .vertical
        Vstack.spacing = 5
        Vstack.alignment = .leading
        return Vstack
    }()
    
    private let foodImage : UIImageView = {
        let foodImage = UIImageView()
        foodImage.contentMode = .scaleAspectFill
        foodImage.clipsToBounds = true
        return foodImage
    }()
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        return nameLabel
    }()
    
    private let ingredientsStackView : UIStackView = {
        let ingredientsStackView = UIStackView()
        ingredientsStackView.backgroundColor = .darkGray
        ingredientsStackView.axis = .horizontal
        ingredientsStackView.layer.cornerRadius = 2
        ingredientsStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return ingredientsStackView
    }()
    
    private let usedIngredientsCount : UILabel = {
        let usedIngredients = UILabel()
        usedIngredients.textColor = .white
        usedIngredients.textAlignment = .left
        usedIngredients.font = .systemFont(ofSize: 15, weight: .medium)
        usedIngredients.numberOfLines = 0
        return usedIngredients
    }()
    
    private let UnusedIngredientsCount : UILabel = {
        let UnusedIngredientsCount = UILabel()
        UnusedIngredientsCount.textColor = .white
        UnusedIngredientsCount.textAlignment = .left
        UnusedIngredientsCount.font = .systemFont(ofSize: 15, weight: .medium)
        UnusedIngredientsCount.numberOfLines = 0
        return UnusedIngredientsCount
    }()
    
    private let likeStackView : UIStackView = {
        let likeStackView = UIStackView()
        likeStackView.backgroundColor = .darkGray
        likeStackView.alignment = .center
        likeStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return likeStackView
    }()
    
    private let likeCount : UILabel = {
        let likeCount = UILabel()
        likeCount.textColor = .white
        likeCount.textAlignment = .left
        likeCount.font = .systemFont(ofSize: 15, weight: .medium)
        likeCount.numberOfLines = 0
        return likeCount
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 20
        foodImage.layer.cornerRadius = 20
        likeStackView.layer.cornerRadius = 5
    }
    
    
    func layout() {
        
        contentView.backgroundColor = UIColor(red: 0.23, green: 0.37, blue: 0.04, alpha: 1.00)
        self.foodImage.tintColor = UIColor.black

        contentView.addSubview(foodImage)
        contentView.addSubview(Vstack)
        contentView.addSubview(likeStackView)
        
        likeStackView.addArrangedSubview(likeCount)
        
        Vstack.addArrangedSubview(nameLabel)
        Vstack.addArrangedSubview(ingredientsStackView)
        
        ingredientsStackView.addArrangedSubview(usedIngredientsCount)
        ingredientsStackView.addArrangedSubview(UnusedIngredientsCount)

        Vstack.translatesAutoresizingMaskIntoConstraints = false
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsStackView.translatesAutoresizingMaskIntoConstraints = false
        usedIngredientsCount.translatesAutoresizingMaskIntoConstraints = false
        UnusedIngredientsCount.translatesAutoresizingMaskIntoConstraints = false
        likeStackView.translatesAutoresizingMaskIntoConstraints = false
        likeCount.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            foodImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            foodImage.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            likeStackView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
            likeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),

            Vstack.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            Vstack.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 50),
            Vstack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            Vstack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),

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
        self.usedIngredientsCount.text = "✔︎\(food.usedIngredientCount)"
        self.UnusedIngredientsCount.text = "✖︎\(food.missedIngredientCount)"
        self.likeCount.text = "♡\(food.likes)"
        self.foodImage.sd_setImage(with: URL(string: food.image)) { image, error, cacheType, url in
            if let error = error {
                print("Error loading image: \(error)🔴🔴🔴")
                self.foodImage.image = UIImage(systemName: "photo")
            }
        }
    }
    
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.usedIngredientsCount.text = nil
        self.UnusedIngredientsCount.text = nil
        self.likeCount.text = nil
        self.foodImage.image = nil
    }
}

