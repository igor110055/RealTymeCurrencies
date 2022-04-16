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
  
  func request<T: Decodable>(dataType: T.Type,
                             onQueue: DispatchQueue,
                             completion: @escaping (Result<T, Error>) -> Void)
  
}

extension NetworkProviderProtocol {
  
  func request<T>(dataType: T.Type,
                  onQueue: DispatchQueue,
                  completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
    urlSession.dataTask(service.urlRequest, dataType: dataType) { result in
      onQueue.async {
        completion(result)
      }
    }.resume()
  }
  
}
