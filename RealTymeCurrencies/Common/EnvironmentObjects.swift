//
//  EnvironmentObjects.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 17.04.2022.
//

import Foundation

class EnvironmentObjects: ObservableObject {
  
  @Published var selectedFiatCurrencySymbol = LocalStorage.shared.selectedFiatCurrency {
    didSet {
      LocalStorage.shared.selectedFiatCurrency = selectedFiatCurrencySymbol
    }
  }
  
}
