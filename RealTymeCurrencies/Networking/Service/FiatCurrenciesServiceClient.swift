//
//  FiatCurrenciesServiceClient.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import Foundation

struct FiatCurrenciesServiceClient: NetworkProviderProtocol {
  
  var urlSession: SessionProtocol
  var service: NetworkService
  
  init(urlSession: SessionProtocol = Session(), clientService: NetworkService) {
    self.urlSession = urlSession
    self.service = clientService
  }
  
}
