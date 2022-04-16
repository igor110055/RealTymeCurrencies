//
//  FiatCurrencies.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import Foundation

class FiatCurrencies: Decodable {
  
  var fiatCurrencies = [FiatCurrency]()
  
  private enum CodingKeys: String, CodingKey {
    case fiatCurrencies = "data"
  }
  
}

class FiatCurrency: Decodable, ObservableObject, Hashable {
  
  let id: String
  let name: String
  
  static func == (lhs: FiatCurrency, rhs: FiatCurrency) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(name)
  }
  
}

