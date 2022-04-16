//
//  CryptoCurrencyRow.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import SwiftUI

struct CryptoCurrencyRow: View {
  
  @StateObject var cryptoCurrency: CryptoCurrencyDetail
  
  var body: some View {
    HStack {
      Image(uiImage: cryptoCurrency.image)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 30, height: 30)
        .clipped()
      Text(cryptoCurrency.symbol.uppercased())
      Spacer()
      Text(cryptoCurrency.currentPriceString)
    }
    .padding(.top, 5)
    .padding(.bottom, 5)
    .onAppear(perform: { cryptoCurrency.fetchImage() })
    .onDisappear(perform: { cryptoCurrency.cancelFetchingImage() })
  }
  
}

struct CryptoCurrencyRow_Previews: PreviewProvider {
  static var previews: some View {
    CryptoCurrencyRow(cryptoCurrency: CryptoCurrencyDetail()).previewLayout(.sizeThatFits)
  }
}
