//
//  RequestService.swift
//  CatFacts
//
//  Created by Rameez Khan on 3/10/23.
//

import Foundation

final class Service {
    
    func dataTask(urlString: String, session: URLSession = URLSession(configuration: .default), completion: @escaping (Result<Data, ErrorResult>) -> Void) -> URLSessionTask? {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.network(string: "Invalid url format")))
            return nil
        }
        
        let request = Factory.request(method: .GET, url: url)
                
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.network(string: "An error occured during request: \(error.localizedDescription)")))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.network(string: "Unable to process the HTTP response")))
              return
            }
            
            guard response.statusCode == 200 else {
                completion(.failure(.network(string: "Failed response code \(response.statusCode) from the API \(String(describing: response.url?.absoluteString))")))
              return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.network(string: "No data returned from API")))
                return
            }
        }
        task.resume()
        return task
    }
}
