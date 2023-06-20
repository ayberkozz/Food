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
        foodImage.layer.cornerRadius = 15
    }
    
    
    func layout() {
        
        contentView.backgroundColor = UIColor.systemGreen
        self.foodImage.tintColor = UIColor.black

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
            
            Hstack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            Hstack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            Hstack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            Hstack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            foodImage.heightAnchor.constraint(equalToConstant: contentView.frame.size.height / 1.8),
            foodImage.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 3.8),
            
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
                self.foodImage.image = UIImage(systemName: "photo")
            } else {
                print("Image loaded successfully✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅")
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

