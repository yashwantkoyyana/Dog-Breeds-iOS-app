import Foundation

@objc enum RequestType: Int {
    case get, post
    
    var type: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

@objc class RequestModel: NSObject {
    
    final let baseURL = "https://dog.ceo/api"
    
    @objc var path: String {
        ""
    }
    
    @objc var method: RequestType {
        body.isEmpty ? .get : .post
    }
    
    @objc var body: [String: Any] {
        [:]
    }
    
    @objc func urlRequest() -> URLRequest {
        let components = URLComponents(string: "\(baseURL)\(path)")!
        
        var request: URLRequest = URLRequest(url: components.url!)
        request.httpMethod = method.type.uppercased()

        return request
    }
    
    @objc func parseData(_ data: Data) -> ResponseModel? {
        nil;
    }
}
