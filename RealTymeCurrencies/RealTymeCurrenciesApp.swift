//
//  RealTymeCurrenciesApp.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import SwiftUI

@main
struct RealTymeCurrenciesApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .onAppear(perform: setAppareance)
    }
  }
}

private extension RealTymeCurrenciesApp {
  func setAppareance() {
    let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
    UINavigationBar.appearance().largeTitleTextAttributes = attrs
  }
}
