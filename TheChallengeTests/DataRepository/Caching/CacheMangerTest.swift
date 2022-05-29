//
//  CacheMangerTest.swift
//  TheChallengeTests
//
//  Created by Derouiche Elyes on 29/05/2022.
//

import XCTest
import Combine
@testable import TheChallenge

class CacheMangerTest: XCTestCase {
    
    var provider : CacheRepository!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        provider = CacheManager.shared
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_saveMockedMovieIntoCache() {
        // using
        let movie = Movie.mocks.randomElement()
        
        // test random
        guard let movie = movie else {
            XCTFail("Empty Mocks Movie Data")
            return
        }
        
        // prepare
        guard let parsed = try? JSONEncoder().encode(movie) else {
            XCTFail("Couldn't parse Movie model into Data")
            return
        }
        
        // Write
        let functionResult = provider.save(folderType: .movies, identifier: movie.contentID, content: parsed)
        
        XCTAssertTrue(functionResult, "Save Function did fail")
    }
    
    func test_getMoviesFromCache_Test() {
        
        // do
        let savedData = provider
            .get(folderType: .movies, identifier: nil)
        
        // test 1
        guard let savedData = savedData else {
            XCTFail("Data should not be nil")
            return
        }
        
        // test 2
        guard let _ = try? JSONDecoder().decode(Movie.self, from: savedData) else {
            XCTFail("Data should be parseable to ContentWrapper.self")
            return
        }
    }
    
}
