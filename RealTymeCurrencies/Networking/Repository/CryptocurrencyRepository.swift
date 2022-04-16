//
//  CryptocurrencyRepository.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import Foundation

protocol CryptocurrenciesRepositoryProtocol {
  func fetchCryptocurrencies()
}

class CryptocurrencyRepository: CryptocurrenciesRepositoryProtocol {
  
  var client: NetworkProviderProtocol?
  @Published var cryptoCurrencies = [CryptoCurrency]()
  @Published var error: Error?
  
  func fetchCryptocurrencies() {
    client = CryptocurrenciesServiceClient(clientService: CryptocurrenciesService())
    fetchCryptoCurrencies(client: client!)
  }
  
}

private extension CryptocurrencyRepository {
  
  func fetchCryptoCurrencies(client: NetworkProviderProtocol) {
    client.request(dataType: [CryptoCurrency].self, onQueue: .main) { [weak self] result in
      do {
        self?.cryptoCurrencies = try result.get()
      } catch {
        self?.error = error
      }
    }
  }
  
}
