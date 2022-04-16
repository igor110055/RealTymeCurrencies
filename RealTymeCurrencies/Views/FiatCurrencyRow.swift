//
//  FiatCurrencyRow.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import SwiftUI

struct FiatCurrencyRow: View {
  
  @StateObject var fiatCurrency: FiatCurrency
  
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    HStack {
      Text(fiatCurrency.id)
      Spacer()
      Text(fiatCurrency.name)
    }
    .contentShape(Rectangle())
    .padding(.top, 5)
    .padding(.bottom, 5)
  }
  
}

