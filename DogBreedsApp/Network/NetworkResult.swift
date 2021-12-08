import Foundation

@objc class NetworkResult: NSObject {
    
    public private(set) var success: Any?
    public private(set) var failure: Error?
    
    private override init() {
        super.init()
        success = nil
        failure = nil
    }
    
    public convenience init<Success, Failure>(_ success: Success, _ failure: Failure) where Failure: Error {
        self.init()
        self.success = success
        self.failure = failure
    }
}
