//
//  LocalStorage.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 17.04.2022.
//

import Foundation

class LocalStorage: ObservableObject {
  
  static let shared = LocalStorage()
  
  private let userDefaults: UserDefaults?
  
  @Published var selectedFiatCurrency: String {
    didSet {
      persistedSelectedFiatCurrency = selectedFiatCurrency
    }
  }
  
  private var persistedSelectedFiatCurrency: String {
    set {
      userDefaults?.set(newValue, forKey: "persistedSelectedFiatCurrency")
    }
    get {
      userDefaults?.string(forKey: "persistedSelectedFiatCurrency") ?? "USD"
    }
  }
  
  // For testing
  init(suiteName: String? = nil) {
    self.userDefaults = UserDefaults(suiteName: suiteName)
    selectedFiatCurrency = userDefaults?.string(forKey: "persistedSelectedFiatCurrency") ?? "USD"
  }
  
}
