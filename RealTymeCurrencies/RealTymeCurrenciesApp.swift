//
//  RealTymeCurrenciesApp.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import SwiftUI

@main
struct RealTymeCurrenciesApp: App {
  
  @ObservedObject var environmentObjects = EnvironmentObjects()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .onAppear(perform: setAppareance)
        .environmentObject(environmentObjects)
    }
  }
}

private extension RealTymeCurrenciesApp {
  func setAppareance() {
    let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
    UINavigationBar.appearance().largeTitleTextAttributes = attrs
  }
}
