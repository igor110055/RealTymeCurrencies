//
//  Environment.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import Foundation

public enum NetworkEnvironment {
  public static let successStatusCodeRange: Range<Int> = 200 ..< 300
  public static let invalidCurrencyErrorCode = 400
  public static let requestDefaultTimeout: TimeInterval = 60
}

public enum HttpMethod: String {
  case get = "GET"
  case post = "POST"
  case patch = "PATCH"
  case delete = "DELETE"
}

