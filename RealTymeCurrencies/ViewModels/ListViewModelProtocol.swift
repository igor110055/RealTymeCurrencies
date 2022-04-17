//
//  ListViewModelProtocol.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import Foundation

protocol ListViewModelProtocol: ObservableObject {
  associatedtype DataItem
  
  var title: String { get }
  var datasource: DataItem { get }
  var showError: Bool { get }
  var errorMessage: String? { get }
  var isFetching: Bool { get }
  func loadData()
}
