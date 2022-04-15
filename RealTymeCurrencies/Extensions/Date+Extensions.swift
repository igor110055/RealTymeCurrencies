//
//  Date+Extensions.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import Foundation

extension Date {
  
  private static let longDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss MM.dd.yyyy"
    return formatter
  }()
  
  var sb_formattedLongDateString: String? {
    return Self.longDateFormatter.string(from: self)
  }
  
}
