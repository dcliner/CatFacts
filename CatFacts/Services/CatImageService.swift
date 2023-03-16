//
//  CatImageService.swift
//  CatFacts
//
//  Created by Rameez Khan on 3/10/23.
//

import Foundation
import UIKit.UIImage

protocol CatImageServiceProtocol : AnyObject {
    func loadImage(urlString: String, _ completion: @escaping ((Result<UIImage, ErrorResult>) -> Void))
}

final class CatImageService: CatImageServiceProtocol {
    
    static let shared = CatImageService()
    
    var task : URLSessionTask?
    
    func loadImage(urlString: String, _ completion: @escaping ((Result<UIImage, ErrorResult>) -> Void)) {
        
        // cancel previous request if already in progress
        self.cancelFetchImage()
        
        task = Service().dataTask(urlString: urlString, completion: { result in
            DispatchQueue.global(qos: .background).async(execute: {
                switch result {
                case .success(let data) :
                    if let image = UIImage(data: data) {
                        completion(.success(image))
                    } else {
                        completion(.failure(.custom(string: "Unable to convert data to Image")))
                    }
                case .failure(let error) :
                    completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                }
            })
        })
    }
    
    func cancelFetchImage() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
