//
//  SessionProtocol.swift
//  NetworkProvider
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import Foundation

public protocol SessionProtocol {
  
  func dataTask<T: Decodable>(_ request: URLRequest,
                              dataType: T.Type,
                              completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask
  
}

