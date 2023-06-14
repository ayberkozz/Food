//
//  CustomCollectionViewCell.swift
//  Food
//
//  Created by Ayberk Öz on 14.06.2023.
//

import UIKit
import SDWebImage

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    private(set) var food: FoodDetailModel!
    
    private let Vstack : UIStackView = {
        let Vstack = UIStackView()
        Vstack.axis = .vertical
        Vstack.spacing = 3
        Vstack.alignment = .center
        return Vstack
    }()
    
    private let foodImage : UIImageView = {
        let foodImage = UIImageView()
        foodImage.contentMode = .scaleAspectFit
        foodImage.clipsToBounds = true
        return foodImage
    }()
    
    private let title : UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 20, weight: .light)
        title.numberOfLines = 0
        return title
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 20
        foodImage.layer.cornerRadius = 20
    }
    
    func layout() {
        
        contentView.backgroundColor = .white
        contentView.addSubview(Vstack)
        
        Vstack.addArrangedSubview(foodImage)
        Vstack.addArrangedSubview(title)
        
        Vstack.translatesAutoresizingMaskIntoConstraints = false
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            Vstack.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            Vstack.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            Vstack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            foodImage.topAnchor.constraint(equalToSystemSpacingBelow: Vstack.topAnchor, multiplier: 1),
            foodImage.heightAnchor.constraint(equalToConstant: contentView.frame.size.height / 1.5),
            foodImage.widthAnchor.constraint(equalToConstant: contentView.frame.size.width / 1.2),
            foodImage.centerXAnchor.constraint(equalTo: Vstack.centerXAnchor),
            
            title.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 8),
            title.centerXAnchor.constraint(equalTo: Vstack.centerXAnchor)

        ])
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with food:FoodDetailModel) {
        self.food = food
        self.title.text = food.title
        self.foodImage.sd_setImage(with: URL(string:food.image))
    }
    
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.title.text = nil
        self.foodImage.image = nil
    }
    
}
