//
//  CryptocurrenciesServiceClient.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import Foundation

struct CryptocurrenciesServiceClient: NetworkProviderProtocol {
  
  let urlSession: SessionProtocol
  let service: NetworkService
  
  init(urlSession: SessionProtocol = Session(), clientService: NetworkService) {
    self.urlSession = urlSession
    self.service = clientService
  }
  
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
