//
//  DogBreedMainTableCell.swift
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

import UIKit

class DogBreedMainTableCell: UITableViewCell {
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var breedImageView: CachedImageView!
    @IBOutlet var breedNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        breedImageView.layer.cornerRadius = 20
        breedImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.layer.cornerRadius = 20
        breedImageView.emptyImage = UIImage(named: "gray_image_background")
        
        //MARK:- Shade a view
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        containerView.layer.shadowRadius = 3.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.masksToBounds = false
    }
    
    func configure(with breed: String, image: String?) {
        self.breedNameLabel.text = breed.capitalizingFirstLetter()
        if let imageURL = image {
            self.breedImageView.loadImage(urlString: imageURL)
        }
    }
    
    deinit {
        print("DogBreedMainTableCell deinit")
    }
}
