import Foundation
import UIKit

protocol Reloadable: AnyObject {
    func reload(item: Breed)
}

@objc class Breed: NSObject {
    var types: [String]
    var breed: String
    
    weak var delegate: Reloadable?
        
    init(breed: String, types: [String]) {
        self.breed = breed
        self.types = types
        super.init()
    }
}
