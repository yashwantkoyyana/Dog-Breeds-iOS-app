import Foundation

@objc class BreedsResponseModel: ResponseModel, Codable {
    
    @objc var message: [String: [String]]
    @objc var status: String
    
    @objc func breeds() -> [Breed] {
        message.map { Breed(breed: $0.key, types: $0.value) }
    }
}
