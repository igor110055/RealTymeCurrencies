//
//  FiatCurrenciesListView.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import SwiftUI

struct FiatCurrenciesListView: View {
  
  @ObservedObject var viewModel: FiatCurrencyListViewModel
  
  @State private var searchText = ""
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var environmentObjects: EnvironmentObjects
  
  init(viewModel: FiatCurrencyListViewModel = FiatCurrencyListViewModel()) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    NavigationView {
      ZStack {
        List {
          ForEach(searchResults, id: \.self) { fiatCurrency in
            FiatCurrencyRow(fiatCurrency: fiatCurrency)
              .onTapGesture {
                LocalStorage.shared.selectedFiatCurrency = fiatCurrency.id
                environmentObjects.selectedFiatCurrencySymbol = fiatCurrency.id
                presentationMode.wrappedValue.dismiss()
              }
          }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(viewModel.title)
        .searchable(text: $searchText)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button("Dismiss") {
              presentationMode.wrappedValue.dismiss()
            }
          }
        }
        
        Text(viewModel.errorMessage ?? "")
          .sb_setHidden(!viewModel.showError)
        
        ProgressView()
          .progressViewStyle(.circular)
          .sb_setHidden(!viewModel.isFetching)
      }
    }
    .onAppear { viewModel.loadData() }
  }
  
  var searchResults: [FiatCurrency] {
    if searchText.isEmpty {
      return viewModel.datasource
    } else {
      return viewModel.datasource.filter {
        $0.id.lowercased().contains(searchText.lowercased()) ||
        $0.name.lowercased().contains(searchText.lowercased())
      }
    }
  }
  
}
