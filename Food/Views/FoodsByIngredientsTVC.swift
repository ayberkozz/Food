//
//  IngredientsTVC.swift
//  Food
//
//  Created by Ayberk Öz on 15.06.2023.
//

import UIKit
import SDWebImage

class FoodsByIngredientsTVC: UICollectionViewCell {
    
    static let reuseIdentifier = "IngredientsTVCIdentifier"
    private(set) var food : FoodsByIngredientsModel!
    
    private let Hstack : UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis = .horizontal
        Hstack.spacing = 1
        Hstack.alignment = .center
        return Hstack
    }()
    
    private let Vstack : UIStackView = {
        let Vstack = UIStackView()
        Vstack.axis = .vertical
        Vstack.spacing = 10
        Vstack.alignment = .leading
        return Vstack
    }()
    
    private let foodImage : UIImageView = {
        let foodImage = UIImageView()
        foodImage.contentMode = .scaleAspectFit
        foodImage.clipsToBounds = true
        return foodImage
    }()
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        nameLabel.numberOfLines = 0
        return nameLabel
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
    }
    
    
    func layout() {
        contentView.backgroundColor = UIColor.systemGreen
        
        contentView.addSubview(Hstack)

        Hstack.addArrangedSubview(Vstack)
        Hstack.addArrangedSubview(foodImage)
        
        Vstack.addArrangedSubview(nameLabel)
        Vstack.addArrangedSubview(usedIngredientsCount)
        Vstack.addArrangedSubview(UnusedIngredientsCount)
        Vstack.addArrangedSubview(likeCount)

        Hstack.translatesAutoresizingMaskIntoConstraints = false
        Vstack.translatesAutoresizingMaskIntoConstraints = false
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        usedIngredientsCount.translatesAutoresizingMaskIntoConstraints = false
        UnusedIngredientsCount.translatesAutoresizingMaskIntoConstraints = false
        likeCount.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            Hstack.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            Hstack.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            Hstack.trailingAnchor.constraint(equalToSystemSpacingAfter: contentView.trailingAnchor, multiplier: -1),
            
            Vstack.topAnchor.constraint(equalTo: Hstack.topAnchor),
            Vstack.leadingAnchor.constraint(equalTo: Hstack.leadingAnchor),
            Vstack.trailingAnchor.constraint(equalTo: Hstack.trailingAnchor),
            
            foodImage.heightAnchor.constraint(equalToConstant: contentView.frame.size.height / 1.5),
            foodImage.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 3),
            foodImage.trailingAnchor.constraint(equalToSystemSpacingAfter: Hstack.trailingAnchor, multiplier: -1),
            foodImage.centerYAnchor.constraint(equalToSystemSpacingBelow: Hstack.centerYAnchor, multiplier: 2),
            
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
        self.foodImage.sd_setImage(with: URL(string: food.image)) { image, error, cacheType, url in
            if let error = error {
                print("Error loading image: \(error)🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴🔴")
                self.foodImage.image = UIImage(systemName: "birthday.cake")
            } else {
                print("Image loaded successfully✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅")
            }
        }
        print(food.image)
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

