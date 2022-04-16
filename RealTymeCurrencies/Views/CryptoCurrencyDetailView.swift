//
//  CryptoCurrencyDetailView.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import SwiftUI

struct CryptoCurrencyDetailView: View {
  
  @StateObject var cryptoCurrencyDetail: CryptoCurrencyDetail
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .center, spacing: 15.0) {
        HStack(alignment: .center) {
          Image(uiImage: cryptoCurrencyDetail.image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150.0, height: 150.0, alignment: .center)
            .clipped()
        }
        
        Text("Symbol: \(cryptoCurrencyDetail.symbol.uppercased())")
        Text("Current Price: \(cryptoCurrencyDetail.currentPriceString)")
        Text("All Time Highest Price: \(cryptoCurrencyDetail.allTimeHighestPriceString)")
        Text("All Time Lowest Price: \(cryptoCurrencyDetail.allTimeLowestPriceString)")
        Text("Highest Price In 24H: \(cryptoCurrencyDetail.highestPriceIn24hString)")
        Text("Lowest Price In 24H: \(cryptoCurrencyDetail.lowestPriceIn24hString)")
        Text("All Time Highest Date: \(cryptoCurrencyDetail.allTimeHighestDateString)")
        Text("All Time Lowest Date: \(cryptoCurrencyDetail.allTimeLowestDateString)")
        Text("Last Updated Date: \(cryptoCurrencyDetail.lastUpdatedDateString)")
      }
    }
    .navigationTitle(cryptoCurrencyDetail.name)
    .padding(.bottom, 30.0)
    .onAppear { cryptoCurrencyDetail.fetchImage() }
    .onDisappear { cryptoCurrencyDetail.cancelFetchingImage() }
  }
  
}

struct CryptoCurrencyDetailView_Previews: PreviewProvider {
  static var previews: some View {
    CryptoCurrencyDetailView(cryptoCurrencyDetail: CryptoCurrencyDetail())
  }
}
