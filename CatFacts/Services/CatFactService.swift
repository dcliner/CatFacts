//
//  CatFactService.swift
//  CatFacts
//
//  Created by Rameez Khan on 3/10/23.
//

import Foundation

protocol CatFactServiceProtocol : AnyObject {
    func fetchFacts(_ completion: @escaping ((Result<CatFact, ErrorResult>) -> Void))
}

final class CatFactService: CatFactServiceProtocol {
    
    static let shared = CatFactService()
    
    let urlString = "https://meowfacts.herokuapp.com/"
    var task : URLSessionTask?
    
    func fetchFacts(_ completion: @escaping ((Result<CatFact, ErrorResult>) -> Void)) {
        
        // cancel previous request if already in progress
        self.cancelFetchFacts()
        
        task = Service().dataTask(urlString: urlString, completion: { result in
            DispatchQueue.global(qos: .background).async(execute: {
                switch result {
                case .success(let data) :
                    do {
                        let decoder = JSONDecoder()
                        let catFactData: CatFact = try decoder.decode(CatFact.self, from: data)
                        completion(.success(catFactData))
                    } catch {
                        completion(.failure(.decoder(string: "Unable to decode Cat Facts data: \(error.localizedDescription)")))
                    }
                case .failure(let error) :
                    completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                }
            })
        })
    }
    
    func cancelFetchFacts() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
