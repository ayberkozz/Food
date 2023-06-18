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
        Vstack.spacing = 3
        Vstack.alignment = .center
        return Vstack
    }()
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.font = .systemFont(ofSize: 15, weight: .medium)
        nameLabel.numberOfLines = 1
        return nameLabel
    }()
    
    private let foodImage : UILabel = {
        let foodImage = UILabel()
        foodImage.textColor = .white
        foodImage.textAlignment = .left
        foodImage.font = .systemFont(ofSize: 24, weight: .thin)
        foodImage.numberOfLines = 0
        return foodImage
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 20
    }
    
    func layout() {
        
        contentView.backgroundColor = UIColor.systemGreen
        contentView.addSubview(Vstack)
        
        Vstack.addArrangedSubview(nameLabel)
        Vstack.addArrangedSubview(foodImage)
        
        Vstack.translatesAutoresizingMaskIntoConstraints = false
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            Vstack.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            Vstack.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            Vstack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            nameLabel.centerXAnchor.constraint(equalTo: Vstack.centerXAnchor),
            
            foodImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            foodImage.centerXAnchor.constraint(equalTo: Vstack.centerXAnchor)

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
        self.foodImage.text = food.image
    }
    
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.foodImage.text = nil
    }
}

