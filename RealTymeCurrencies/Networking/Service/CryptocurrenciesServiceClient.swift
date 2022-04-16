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
  
}
