import XCTest
@testable import DogBreedsApp

class NetworkTests: XCTestCase {

    private let timeout = 10.0
    
    func testBreedsRequest() {
        let expectedCount = 95
        let expectation = XCTestExpectation(description: "Fetch dog breeds")
       
        NetworkManager.breeds { breeds in
            XCTAssertEqual(breeds.count, expectedCount)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: timeout)
    }
}
