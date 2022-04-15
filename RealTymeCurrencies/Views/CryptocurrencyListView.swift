//
//  CryptocurrencyListView.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import SwiftUI

struct CryptocurrencyListView: View {
  
  @ObservedObject var viewModel: CryptocurrencyListViewModel
  
  init(viewModel: CryptocurrencyListViewModel = CryptocurrencyListViewModel()) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        List {
          Section {
            ForEach(viewModel.datasource) { cryptoCurrency in
              NavigationLink(destination: Text(cryptoCurrency.name)) {
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
    .onAppear {
      viewModel.loadData()
    }
  }
  
}


private struct ListHeader: View {
  @State var isPresented = false
  var body: some View {
    HStack {
      Text("Fiat Currency")
      Button("USD") { self.isPresented = true }
      .onTapGesture {
        print("TODO: Implement Later")
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
