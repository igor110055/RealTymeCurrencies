//
//  Double+Extension.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import Foundation

extension Double {
  
  var sb_formattedPriceString: String {
    return NumberUtility.formatValue(NSNumber(value: self), maximumFractionDigits: 2)
  }
  
}
