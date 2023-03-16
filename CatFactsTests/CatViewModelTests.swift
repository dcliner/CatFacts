//
//  CatViewModelTests.swift
//  CatFactsTests
//
//  Created by Rameez Khan on 3/10/23.
//

import XCTest
@testable import CatFacts

final class CatViewModelTests: XCTestCase {
    
    var viewModel: CatViewModel!
    fileprivate var imageService: MockImageService!
    fileprivate var factService: MockFactService!

    override func setUpWithError() throws {
        imageService = MockImageService()
        factService = MockFactService()
        viewModel = CatViewModel(factService: factService, imageService: imageService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        imageService = nil
        factService = nil
    }

    func testFactWithNoService() throws {
        
        let expectation = XCTestExpectation(description: "No Cat fact service available")
        
        // assign no fact service to a view model
        viewModel.factService = nil
        
        // expected to not be able to fetch facts
        viewModel.factErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.getCatFacts()
        wait(for: [expectation], timeout: 5.0)
    }

    func testImageWithNoService() throws {
        
        let expectation = XCTestExpectation(description: "No Cat image service available")
        
        // assign no image service to a view model
        viewModel.imageService = nil
        
        // expected to not be able to fetch image
        viewModel.imageErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.getCatImage()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetCatFacts() throws {
        
        let expectation = XCTestExpectation(description: "Get Cat Facts")
        
        // mock cat facts to a service
        factService.catFact = CatFact(data: ["A cat can spend five or more hours a day grooming himself."])
        
        viewModel.factErrorHandling = { _ in
            XCTAssert(false, "View model shouldn't fetch cat facts without service!")
        }
        
        viewModel.text.bind { _ in
            expectation.fulfill()
        }
        
        viewModel.getCatFacts()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetCatImage() throws {
        
        let expectation = XCTestExpectation(description: "Get Cat Image")
        
        // mock cat image to a service
        imageService.image = UIImage(named: "DefaultCat")
        
        viewModel.imageErrorHandling = { _ in
            XCTAssert(false, "View model shouldn't fetch image without service!")
        }
        
        viewModel.image.bind { _ in
            expectation.fulfill()
        }
        
        viewModel.getCatImage()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetNoCatFacts() throws {

        let expectation = XCTestExpectation(description: "No Cat Facts")

        // mocking nil to a service to trigger error
        factService.catFact = nil

        viewModel.factErrorHandling = { error in
            expectation.fulfill()
        }

        viewModel.getCatFacts()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetNoCatImage() throws {
        
        let expectation = XCTestExpectation(description: "No Cat Image")
        
        // mocking nil to a service to trigger error
        imageService.image = nil
        
        viewModel.imageErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.getCatImage()
        wait(for: [expectation], timeout: 5.0)
    }
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}

fileprivate class MockImageService : CatImageServiceProtocol {
    
    var image : UIImage?

    func loadImage(urlString: String, _ completion: @escaping ((Result<UIImage, ErrorResult>) -> Void)) {

        if let image = image {
            completion(Result.success(image))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No image")))
        }
    }
}

fileprivate class MockFactService : CatFactServiceProtocol {

    var catFact : CatFact?

    func fetchFacts(_ completion: @escaping ((Result<CatFacts.CatFact, CatFacts.ErrorResult>) -> Void)) {

        if let fact = catFact {
            completion(Result.success(fact))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No facts fetched")))
        }
    }
}
