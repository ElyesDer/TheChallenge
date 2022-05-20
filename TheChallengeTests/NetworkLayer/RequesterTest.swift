//
//  RequesterTest.swift
//  TheChallengeTests
//
//  Created by Derouiche Elyes on 20/05/2022.
//

import Foundation
import XCTest
import Combine
@testable import TheChallenge

class RequesterTests: XCTestCase {
    
    var zut: Requester!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        zut = .init()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_request_get_movies() {
        let expectation = self.expectation(description: "Requesting data from canal server")
        
        var contentWrapperResponse: ContentWrapper<[Content]>?
        var data: [Content]?
        
        // with
        let endPoint: APIEndpoint = .init(
            method: .get,
            endURL: .movies)
        
        // do
        zut
            .request(from: endPoint, of: ContentWrapper<[Content]>.self)
            .sink { completion in
                // check for error
                switch completion {
                case .failure(let error) :
                    XCTFail(error.localizedDescription)
                    expectation.fulfill()
                case .finished : break
                }
            } receiveValue: { responseData in
                contentWrapperResponse = responseData
                data = responseData.contents
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10, handler: nil)
        
        // check nullable
        XCTAssertNotNil(contentWrapperResponse)
        XCTAssertNotNil(data)
        
    }
}
