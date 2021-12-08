//
//  BreedCollageImagesRequestModel.swift
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

import Foundation

@objc class BreedCollageImagesRequestModel: RequestModel {
    
    @objc public var breed: String
    
    @objc
    public init(breed: String) {
        self.breed = breed
    }
    
    override var path: String {
        get {
            "/breed/\(breed)/images/random/20"
        }
    }
    
    @objc override func parseData(_ data: Data) -> BreedCollageImagesResponseModel? {
        try? JSONDecoder().decode(BreedCollageImagesResponseModel.self, from: data)
    }
}
