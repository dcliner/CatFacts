//
//  CatFactDataTests.swift
//  CatFactsTests
//
//  Created by Rameez Khan on 3/10/23.
//

import XCTest
@testable import CatFacts

final class CatFactDataTests: XCTestCase {
    
    var catFactExampleJSONData: Data!
    var catFact: CatFact!

    override func setUpWithError() throws {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "CatFactExample", withExtension: "json")!
        catFactExampleJSONData = try! Data(contentsOf: url)
      
        let decoder = JSONDecoder()
        catFact = try! decoder.decode(CatFact.self, from: catFactExampleJSONData)
    }

    override func tearDownWithError() throws {
        catFactExampleJSONData = nil
        catFact = nil
    }

    func testCatFact() throws {
        XCTAssertEqual(catFact.data[0], "A cat can spend five or more hours a day grooming himself.")
    }
    
    func testEmptyCatFactData() throws {
        catFactExampleJSONData = Data()
        
    }

}
