//
//  BreedImageRequestModel.swift
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

import Foundation

@objc class BreedImageRequestModel: RequestModel {
    
    @objc public var breed: String
    
    @objc
    public init(breed: String) {
        self.breed = breed
    }
    
    override var path: String {
        get {
            "/breed/\(breed)/images/random"
        }
    }
    
    @objc override func parseData(_ data: Data) -> BreedImageResponseModel? {
        try? JSONDecoder().decode(BreedImageResponseModel.self, from: data)
    }
}
