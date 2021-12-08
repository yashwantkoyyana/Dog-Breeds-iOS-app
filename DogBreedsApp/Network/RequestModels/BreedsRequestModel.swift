import Foundation

@objc class BreedsRequestModel: RequestModel {
    override var path: String {
        get {
            "/breeds/list/all"
        }
    }
    
    @objc override func parseData(_ data: Data) -> ResponseModel? {
        try? JSONDecoder().decode(BreedsResponseModel.self, from: data)
    }
}
