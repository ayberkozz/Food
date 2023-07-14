//
//  favCVC.swift
//  Food
//
//  Created by Ayberk Öz on 13.07.2023.
//

import UIKit
import SDWebImage

class favCVC: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    private(set) var Recipe: RecipeModel!
    
    private let Vstack : UIStackView = {
        let Vstack = UIStackView()
        Vstack.axis = .vertical
        Vstack.spacing = 2
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
        title.textColor = .white
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 20, weight: .semibold)
        title.numberOfLines = 0
        return title
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 20
        foodImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        foodImage.layer.cornerRadius = 20
    }
    
    func layout() {
        
        contentView.backgroundColor = UIColor(red: 0.77, green: 0.07, blue: 0.02, alpha: 1.00)
        
        contentView.addSubview(title)
        self.foodImage.tintColor = UIColor.black

        contentView.addSubview(Vstack)

        Vstack.addArrangedSubview(foodImage)
        Vstack.addArrangedSubview(title)

        Vstack.translatesAutoresizingMaskIntoConstraints = false
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            Vstack.topAnchor.constraint(equalTo: contentView.topAnchor),
            Vstack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            Vstack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            Vstack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),

            foodImage.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            foodImage.heightAnchor.constraint(equalToConstant: contentView.frame.height / 2),

        ])
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with Recipe:RecipeModel) {
        self.Recipe = Recipe
        self.title.text = "\(Recipe.title)"
        self.foodImage.sd_setImage(with: URL(string:Recipe.image)) { image, error, cacheType, url in
            if error != nil {
                self.foodImage.image = UIImage(systemName: "photo")
            }
        }
    }
    
    
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.title.text = nil
        self.foodImage.image = nil
    }
}
