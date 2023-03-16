//
//  CatViewModel.swift
//  CatFacts
//
//  Created by Rameez Khan on 3/10/23.
//

import Foundation
import UIKit.UIImage

public class CatViewModel {
    
    let text = Box("")
    let image: Box<UIImage?> = Box(nil) // no image initially
    
    weak var factService: CatFactServiceProtocol?
    weak var imageService: CatImageServiceProtocol?
    
    var factErrorHandling : ((ErrorResult?) -> Void)?
    var imageErrorHandling : ((ErrorResult?) -> Void)?
    
    init(factService: CatFactServiceProtocol = CatFactService.shared, imageService: CatImageServiceProtocol = CatImageService.shared ) {
        self.factService = factService
        self.imageService = imageService
    }
    
    func fetchData() {
        getCatImage()
        getCatFacts()
    }
    
    func getCatFacts() {
        
        guard let factService = factService else {
            factErrorHandling?(ErrorResult.custom(string: "Missing fact service!"))
            return
        }
        factService.fetchFacts() { [weak self] result in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let catFact):
                    self.text.value = catFact.data[0]
                case .failure(let error):
                    self.factErrorHandling?(error)
                }
            }
        }
    }
    
    func getCatImage() {
        
        guard let imageService = imageService else {
            imageErrorHandling?(ErrorResult.custom(string: "Missing image service!"))
            return
        }
        
        let catImagebaseURL = "https://placekitten.com/"
        let imageDimension = Int.random(in: 200...500)
        let catImageURLString = "\(catImagebaseURL)/\(imageDimension)/\(imageDimension)"
//        let catImageURLString = "https://placekitten.com/300/300"
        
        imageService.loadImage(urlString: catImageURLString) { [weak self] result in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let catImage):
                    self.image.value = catImage
                case .failure(let error):
                    self.imageErrorHandling?(error)
                }
            }
        }
    }
}
