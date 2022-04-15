//
//  View+Extension.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 16.04.2022.
//

import SwiftUI

extension View {
  
  func sb_setHidden(_ hidden: Bool) -> some View {
    opacity(hidden ? 0 : 1)
  }
  
}
