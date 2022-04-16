//
//  FiatCurrencyListViewModel.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import Combine
import SwiftUI

class FiatCurrencyListViewModel: ListViewModelProtocol {
  
  @Published private(set) var title = "Fiat Currencies"
  @Published private(set) var showError = false
  @Published private(set) var isFetching = false
  @Published private(set) var datasource: [FiatCurrency] = []

  private(set) var errorMessage: String?
  private var repository: FiatCurrenciesRepositoryProtocol
  private var cancellables = Set<AnyCancellable>()
  
  private static var fiatCurrencies = [FiatCurrency]()
  
  init(repository: FiatCurrenciesRepositoryProtocol = FiatCurrenciesRepository()) {
    self.repository = repository
  }
  
  func loadData() {
    if !Self.fiatCurrencies.isEmpty {
      datasource = Self.fiatCurrencies
      return
    }
    
    guard let repo = repository as? FiatCurrenciesRepository else { return }
    
    isFetching = true
    repo.fetchFiatCurrencies()
    
    repo.$fiatCurrencies.sink { [weak self] fiatCurrencies in
      self?.handleSuccess(data: fiatCurrencies)
    }
    .store(in: &cancellables)
    
    repo.$error.sink { [weak self] error in
      self?.handleFailure(error: error)
    }
    .store(in: &cancellables)
  }
  
}

private extension FiatCurrencyListViewModel {
  
  func handleSuccess(data: [FiatCurrency]) {
    Self.fiatCurrencies = data
    datasource = data
    title = "\("Fiat Currencies") (\(datasource.count))"
    showError = false
    isFetching = false
  }
  
  func handleFailure(error: Error?) {
    Self.fiatCurrencies = []
    guard let error = error else { return }
    errorMessage = "\(error)"
    showError = true
    isFetching = false
  }
  
}
