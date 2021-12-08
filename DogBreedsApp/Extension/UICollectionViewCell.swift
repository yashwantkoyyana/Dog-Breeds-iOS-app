//
//  UICollectionViewCell.swift
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseId: String {
        String(describing: self)
    }
    
    class func registerAsNibWith(collectionView: UICollectionView) {
        let cellName = String(describing: self)
        collectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
    }

    class func registerAsCellClassWith(collectionView: UICollectionView) {
        let cellName = String(describing: self)
        collectionView.register(self.self, forCellWithReuseIdentifier: cellName)
    }
}
