//
//  BreedDetailViewModel.swift
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

import UIKit

class BreedDetailViewModel: NSObject {
    
    var dogBreed: Breed?
    
    var onBreedImagessDidFetch: (() -> ())?
    
    var breedImages: [String] = []
    
    var isHorizontalModeEnabled = false
    
    deinit {
        print("BreedDetailViewModel deinit")
    }
}


// MARK: - Network Calls
extension BreedDetailViewModel {
    func getBreedImagesFromServer(for breed: String) {
        DogBreedsNetworkService.breedCollageImages(breed) { [weak self] (images) in
            guard let self = self else {return}
            
            self.breedImages = images
            self.onBreedImagessDidFetch?()
        }
    }
}
