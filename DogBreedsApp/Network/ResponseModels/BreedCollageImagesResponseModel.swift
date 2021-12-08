//
//  BreedCollageImagesResponseModel.swift
//  DogBreedsApp
//
//  Created by Yash Koyyana on 10/5/21.
//

import Foundation

@objc class BreedCollageImagesResponseModel: ResponseModel, Codable {
    
    @objc var message: [String]
    @objc var status: String
}
