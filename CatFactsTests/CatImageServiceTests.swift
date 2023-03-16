//
//  CatImageServiceTests.swift
//  CatFactsTests
//
//  Created by Rameez Khan on 3/10/23.
//

import XCTest
@testable import CatFacts

final class CatImageServiceTests: XCTestCase {

    func testCancelLoadImageRequest() throws {
        
        let imageURLString = "https://placekitten.com/300/300"
        // giving a previous session
        CatImageService.shared.loadImage(urlString: imageURLString) { _ in
            // ignore call
        }
        
        // Expected to task nil after cancel
        CatImageService.shared.cancelFetchImage()
        XCTAssertNil(CatImageService.shared.task, "Expected task nil")
    }

}
