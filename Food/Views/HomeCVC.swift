//
//  HomeCVC.swift
//  Food
//
//  Created by Ayberk Öz on 14.07.2023.
//

import UIKit

class HomeCVC: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"

    
    private let BgImage : UIImageView = {
        let BgImage = UIImageView()
        BgImage.contentMode = .scaleAspectFill
        BgImage.clipsToBounds = true
        return BgImage
    }()
    
    private let bottomView : UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor(white: 0.9, alpha: 0.9)
        return bottomView
    }()
    
    private let BottomStack : UIStackView = {
        let BottomStack = UIStackView()
        BottomStack.axis = .vertical
        BottomStack.alignment = .leading
        BottomStack.spacing = 10
        return BottomStack
    }()
    
    private let Title : UILabel = {
        let Title = UILabel()
        Title.textColor = .black
        Title.numberOfLines = 0
        Title.font = .systemFont(ofSize: 20, weight: .black)
        return Title
    }()
    
    private let descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        return descriptionLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        BgImage.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bottomView.layer.cornerRadius = 20
    }
    
    func layout() {
        
        BgImage.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        BottomStack.translatesAutoresizingMaskIntoConstraints = false
        Title.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(BgImage)
        contentView.addSubview(bottomView)
        
        bottomView.addSubview(BottomStack)

        BottomStack.addArrangedSubview(Title)
        BottomStack.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            
            BgImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            BgImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            BgImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            BgImage.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            bottomView.heightAnchor.constraint(equalToConstant: contentView.frame.height / 3),
            bottomView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            BottomStack.topAnchor.constraint(equalToSystemSpacingBelow: bottomView.topAnchor, multiplier: 3),
            BottomStack.leadingAnchor.constraint(equalToSystemSpacingAfter: bottomView.leadingAnchor, multiplier: 1),
            BottomStack.trailingAnchor.constraint(equalToSystemSpacingAfter: bottomView.trailingAnchor, multiplier: -1),
            
        ])
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage?, title: String, description: String) {
        BgImage.image = image
        Title.text = title
        descriptionLabel.text = description
    }
    
    
}
