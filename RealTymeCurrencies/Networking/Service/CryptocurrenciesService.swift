//
//  CryptocurrenciesService.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import Foundation

struct CryptocurrenciesService: NetworkService {
  
  var fiatCurrency: String
  
  var baseURL: String { "https://api.coingecko.com/api/v3/" }
  
  var path: String { "coins/markets" }
  
  var method: HttpMethod { .get }
  
  var httpBody: Encodable? { nil }
  
  var headers: [String : String]? { nil }
  
  var queryParameters: [URLQueryItem]? {
    [URLQueryItem(name: "vs_currency", value: fiatCurrency),
     URLQueryItem(name: "order", value: "market_cap_des"),
     URLQueryItem(name: "per_page", value: "250"),
     URLQueryItem(name: "page", value: "1")]
  }
  
  var timeout: TimeInterval? { 30.0 }
  
}
