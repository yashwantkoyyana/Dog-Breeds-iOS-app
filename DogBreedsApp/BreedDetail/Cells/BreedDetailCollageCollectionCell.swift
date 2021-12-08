//
//  BreedDetailCollageCollectionCell.swift
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

import UIKit

class BreedDetailCollageCollectionCell: UICollectionViewCell {

    var breedImageView = CachedImageView(cornerRadius: 4, emptyImage: UIImage(named: "gray_image_background"))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }

    private func setupViews() {
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        
        breedImageView.contentMode = .scaleAspectFill
        breedImageView.clipsToBounds = true
        addSubview(breedImageView)
        breedImageView.fillSuperview()
    }
    
    
    func configure(imageURL: String, isHorizontalModeEnabled: Bool) {
        self.breedImageView.loadImage(urlString: imageURL)
        breedImageView.contentMode = isHorizontalModeEnabled ? .scaleAspectFit : .scaleAspectFill
        self.backgroundColor = isHorizontalModeEnabled ? .clear : .lightGray
    }
    
    deinit {
        print("BreedDetailCollageCollectionCell deinit")
    }
}
