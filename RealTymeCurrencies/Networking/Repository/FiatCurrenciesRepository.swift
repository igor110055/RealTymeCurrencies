//
//  FiatCurrenciesRepository.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import Foundation

protocol FiatCurrenciesRepositoryProtocol {
  func fetchFiatCurrencies()
}

class FiatCurrenciesRepository: FiatCurrenciesRepositoryProtocol {
  
  var client: NetworkProviderProtocol?
  @Published var fiatCurrencies = [FiatCurrency]()
  @Published var error: Error?
  
  func fetchFiatCurrencies() {
    client = FiatCurrenciesServiceClient(clientService: FiatCurrenciesService())
    fetchFiatCurrencies(client: client!)
  }
  
}

private extension FiatCurrenciesRepository {
  
  func fetchFiatCurrencies(client: NetworkProviderProtocol) {
    client.request(dataType: FiatCurrencies.self, onQueue: .main) { [weak self] result in
      switch result {
      case .success(let currencies):
        self?.fiatCurrencies = currencies.fiatCurrencies
      case .failure(let error):
        self?.error = error
      }
    }
  }
  
}
