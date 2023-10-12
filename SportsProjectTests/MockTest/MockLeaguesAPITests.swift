//
//  MockLeaguesAPITests.swift
//  SportsProjectTests
//
//  Created by Mohammed Adel on 12/10/2023.
//

import XCTest
@testable import SportsProject

final class MockLeaguesAPITests: XCTestCase {
    
    var networkManager: MockLeaguesAPI!
    
    override func setUpWithError() throws {
        networkManager = MockLeaguesAPI(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        networkManager = nil
    }
    
    func testGetLeaguesData() {
        let predicatedCount = 6
        var actualCount: Int?
        var error: NSError?
        
        networkManager.getLeaguesData(met: "", APIKey: "", pathURL: "") { result in
            switch result {
            case .success(let success):
                actualCount = success?.result?.count
            case .failure(let failure):
                error = failure
                XCTFail()
            }
        }
        XCTAssertNil(error)
        XCTAssertEqual(actualCount, predicatedCount, "Leagues count equal 6")
    }
}
