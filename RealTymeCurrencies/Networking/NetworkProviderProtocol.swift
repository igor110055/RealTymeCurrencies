//
//  NetworkProviderProtocol.swift
//  NetworkProvider
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import Foundation

public protocol NetworkProviderProtocol {
  
  var urlSession: SessionProtocol { get }
  var service: NetworkService { get }
  
  func dataTask<T: Decodable>(dataType: T.Type,
                              onQueue: DispatchQueue,
                              completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask
  
}

extension NetworkProviderProtocol {
  
  func dataTask<T: Decodable>(dataType: T.Type,
                              onQueue: DispatchQueue,
                              completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
    return urlSession.dataTask(service.urlRequest, dataType: dataType) { result in
      onQueue.async {
        completion(result)
      }
    }
  }
  
}
