//
//  NumberUtility.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import Foundation

class NumberUtility {
  
  private static let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.locale = .current
    formatter.numberStyle = .decimal
    return formatter
  }()
  
  class func formatValue(_ value: NSNumber,
                         minimumFractionDigits: Int = 0,
                         maximumFractionDigits: Int = 0) -> String {
    numberFormatter.minimumFractionDigits = minimumFractionDigits
    numberFormatter.maximumFractionDigits = maximumFractionDigits
    return numberFormatter.string(from: value) ?? ""
  }
  
}
