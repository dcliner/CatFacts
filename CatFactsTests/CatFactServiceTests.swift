//
//  CatFactServiceTests.swift
//  CatFactsTests
//
//  Created by Rameez Khan on 3/10/23.
//

import XCTest
@testable import CatFacts

final class CatFactServiceTests: XCTestCase {

    func testCancelFetchRequest() throws {
        
        // giving a previous session
        CatFactService.shared.fetchFacts { _ in
            // ignore call
        }
        
        // Expected to task nil after cancel
        CatFactService.shared.cancelFetchFacts()
        XCTAssertNil(CatFactService.shared.task, "Expected task nil")
    }
    
}
