//
//  CryptocurrencyRepository.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import Foundation

protocol CryptocurrenciesRepositoryProtocol {
  func fetchCryptocurrencies(fiatCurrency: String)
}

class CryptocurrencyRepository: CryptocurrenciesRepositoryProtocol {
  
  var client: NetworkProviderProtocol?
  @Published var cryptoCurrencies = [CryptoCurrency]()
  @Published var error: Error?
  
  private var previousDataTask: URLSessionDataTask?
  
  init(client: NetworkProviderProtocol? = nil) {
    self.client = client
  }
  
  func fetchCryptocurrencies(fiatCurrency: String) {
    previousDataTask?.cancel()
    client = CryptocurrenciesServiceClient(urlSession: client?.urlSession ?? Session(),
                                           clientService: client?.service ?? CryptocurrenciesService(fiatCurrency: fiatCurrency))
    fetchCryptoCurrencies(client: client!)
  }
  
}

private extension CryptocurrencyRepository {
  
  func fetchCryptoCurrencies(client: NetworkProviderProtocol) {
    previousDataTask = client.dataTask(dataType: [CryptoCurrency].self, onQueue: .main) { [weak self] result in
      self?.client = nil
      do {
        self?.cryptoCurrencies = try result.get()
      } catch {
        self?.error = error
      }
    }
    previousDataTask?.resume()
  }
  
}
