//
//  ErrorResult.swift
//  CatFacts
//
//  Created by Rameez Khan on 3/10/23.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case decoder(string: String)
    case custom(string: String)
}
