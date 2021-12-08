//
//  DogBreedListViewModel.swift
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

import UIKit

class DogBreedListViewModel: NSObject {
    
    var onDogBreedsDidFetch: (([Breed]) -> ())?
    var onBreedImageDidFetch: (() -> ())?
    
    var isSearchActive: Bool = false
    var searchText = ""
    
    var breeds: [Breed] = []
    var breedImages: [String: String] = [:]
    
    deinit {
        print("DogBreedListViewModel deinit")
    }
}


// MARK: - Network Calls
extension DogBreedListViewModel {
    func getBreedsListFromServer() {
        DogBreedsNetworkService.breeds { [weak self] (breeds) in
            guard let self = self else {return}
            
            self.onDogBreedsDidFetch?(breeds)
        }
    }
    
    func getBreedImageFromServer(for breed: String) {
        DogBreedsNetworkService.breedImage(breed) { [weak self] (breedImageURL) in
            guard let self = self else {return}
            
            self.breedImages[breed] = breedImageURL
            self.onBreedImageDidFetch?()
        }
    }
    
    func getSearchedBreed() -> [Breed] {
        guard !searchText.isEmpty else {
            return breeds
        }
        return breeds.filter({ $0.breed.lowercased().contains(searchText.lowercased()) })
    }
}


// MARK: - Table View
extension DogBreedListViewModel {
    var numberOfTableRows: Int {
        getBreedsData().count
    }
    
    func getBreedsData() -> [Breed] {
        if isSearchActive {
            return getSearchedBreed()
        }
        return breeds
    }
}
