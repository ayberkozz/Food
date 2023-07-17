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
    
    let containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let bottomView : UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor(white: 0.9, alpha: 0.9)
        return bottomView
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 20, weight: .semibold)
        title.textColor = .white
        return title
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
        
    func layout() {

        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(bottomView)
        
        bottomView.addSubview(title)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            bottomView.widthAnchor.constraint(equalToConstant: self.frame.width),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: self.frame.height / 4),
            
            title.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -8),
            title.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
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
        self.imageView.sd_setImage(with: URL(string:Recipe.image)) { image, error, cacheType, url in
            if error != nil {
                self.imageView.image = UIImage(systemName: "photo")
            }
        }
    }
    
    
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.title.text = nil
        self.imageView.image = nil
    }
}
