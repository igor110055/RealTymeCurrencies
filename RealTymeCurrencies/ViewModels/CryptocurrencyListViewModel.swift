//
//  CryptocurrencyListViewModel.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import Foundation
import Combine

class CryptocurrencyListViewModel: ListViewModelProtocol {
  
  @Published private(set) var title = "Cryptocurrencies"
  @Published private(set) var datasource: [CryptoCurrencyDetail] = []
  @Published private(set) var showError = false
  @Published private(set) var isFetching = false
  
  private(set) var errorMessage: String?
  private var repository: CryptocurrenciesRepositoryProtocol
  private var cancellables = Set<AnyCancellable>()
  private var fiatCurrency = LocalStorage.shared.selectedFiatCurrency
  
  private lazy var timer = SBTimer(timeInterval: 10.0, skipFirstTick: true) { [weak self] in
    self?.loadData()
  }
  
  init(repository: CryptocurrenciesRepositoryProtocol = CryptocurrencyRepository()) {
    self.repository = repository
    timer.start()
    handleFiatCurrencyChanges()
  }
  
  func loadData() {
    guard let repo = repository as? CryptocurrencyRepository else { return }
    
    isFetching = true
    repo.fetchCryptocurrencies(fiatCurrency: fiatCurrency)
    
    repo.$cryptoCurrencies.sink { [weak self] cryptoCurrency in
      self?.handleSuccess(data: cryptoCurrency)
    }
    .store(in: &cancellables)
    
    repo.$error.sink { [weak self] error in
      self?.handleFailure(error: error)
    }
    .store(in: &cancellables)
  }
  
  deinit {
    timer.stop()
  }
  
}

private extension CryptocurrencyListViewModel {
  
  func handleSuccess(data: [CryptoCurrency]) {
    datasource = CryptoCurrencyAdaptor.generateCryptoCurrencyDetailList(from: data)
    title = "\("Cryptocurrencies") (\(datasource.count))"
    showError = false
    isFetching = false
  }
  
  func handleFailure(error: Error?) {
    guard let error = error else { return }
    errorMessage = "\(error)"
    showError = true
    isFetching = false
  }
  
  func handleFiatCurrencyChanges() {
    LocalStorage.shared.$selectedFiatCurrency.sink { [weak self] fiatCurrency in
      if self?.fiatCurrency == fiatCurrency { return }
      self?.fiatCurrency = fiatCurrency
      self?.loadData()
    }
    .store(in: &cancellables)
  }
  
}

