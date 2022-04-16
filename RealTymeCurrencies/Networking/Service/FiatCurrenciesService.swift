//
//  FiatCurrenciesService.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import Foundation

struct FiatCurrenciesService: NetworkService {
  
  var baseURL: String { "https://api.coinbase.com/v2/" }
  
  var path: String { "currencies" }
  
  var method: HttpMethod { .get }
  
  var httpBody: Encodable? { nil }
  
  var headers: [String : String]? { nil }
  
  var queryParameters: [URLQueryItem]? { nil }
  
  var timeout: TimeInterval? { 30.0 }
  
}
