//
//  CryptocurrencyListView.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import SwiftUI

struct CryptocurrencyListView: View {
  
  @ObservedObject var viewModel: CryptocurrencyListViewModel
  @EnvironmentObject var environmentObjects: EnvironmentObjects
  
  init(viewModel: CryptocurrencyListViewModel = CryptocurrencyListViewModel()) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        List {
          Section {
            ForEach(viewModel.showError ? [] : viewModel.datasource) { cryptoCurrency in
              NavigationLink(destination: CryptoCurrencyDetailView(cryptoCurrencyDetail: cryptoCurrency)) {
                CryptoCurrencyRow(cryptoCurrency: cryptoCurrency)
              }
            }
            .sb_setHidden(viewModel.showError)
          } header: {
            ListHeader()
          }
          .navigationTitle(viewModel.title)
        }
        .listStyle(.inset)
        
        Text(viewModel.errorMessage ?? "")
          .sb_setHidden(!viewModel.showError)
        
        ProgressView()
          .progressViewStyle(.circular)
          .sb_setHidden(!viewModel.isFetching)
      }
    }
    .navigationViewStyle(.stack)
    .onAppear { viewModel.loadData() }
  }
  
}


private struct ListHeader: View {
  
  @State var isPresented = false
  @EnvironmentObject var environmentObjects: EnvironmentObjects
  
  var body: some View {
    HStack {
      Text("Fiat Currency")
      Button(environmentObjects.selectedFiatCurrencySymbol) { self.isPresented = true }
      .fullScreenCover(isPresented: $isPresented) {
        FiatCurrenciesListView()
      }
    }
    .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
  }
}

struct CryptocurrencyListView_Previews: PreviewProvider {
  static var previews: some View {
    CryptocurrencyListView().previewLayout(.sizeThatFits)
  }
}
