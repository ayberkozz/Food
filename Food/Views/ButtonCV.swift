//
//  ButtonCV.swift
//  Food
//
//  Created by Ayberk Öz on 20.06.2023.
//

import Foundation

import UIKit

class ButtonCVC: UICollectionViewCell {
    
    static let identifier = "ButtonCVC"
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    func layout() {
        
        contentView.backgroundColor = .systemGreen


        NSLayoutConstraint.activate([



        ])
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {

    }
    
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
}

