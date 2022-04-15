//
//  CryptoCurrencyDetail.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import UIKit

struct CryptoCurrency: Decodable {
  
  let id: String
  let symbol: String
  let name: String
  var imageUrlString: String?
  
  var currentPrice: Double
  var highestPriceIn24h: Double
  var lowestPriceIn24h: Double
  var allTimeHighestPrice: Double
  var allTimeLowestPrice: Double
  var allTimeHighestDate: Date?
  var allTimeLowestDate: Date?
  var lastUpdatedDate: Date?
  
  private enum CodingKeys: String, CodingKey {
    case id, symbol, name
    case imageUrlString = "image"
    case currentPrice = "current_price"
    case highestPriceIn24h = "high_24h"
    case lowestPriceIn24h = "low_24h"
    case allTimeHighestPrice = "ath"
    case allTimeLowestPrice = "atl"
    case allTimeHighestDate = "ath_date"
    case allTimeLowestDate = "atl_date"
    case lastUpdatedDate = "last_updated"
  }
  
}

class CryptoCurrencyDetail: Identifiable, ObservableObject {
  
  @Published var image: UIImage
  @Published var currentPrice: Double
  @Published var highestPriceIn24h: Double
  @Published var lowestPriceIn24h: Double
  @Published var allTimeHighestPrice: Double
  @Published var allTimeLowestPrice: Double
  @Published var allTimeHighestDate: Date?
  @Published var allTimeLowestDate: Date?
  @Published var lastUpdatedDate: Date?
  
  let id: String
  lazy var symbol: String = { cryptoCurrency.symbol }()
  lazy var name: String = { cryptoCurrency.name }()
  
  private let cryptoCurrency: CryptoCurrency
  private let placeholderImage = UIImage(systemName: "photo")!
  
  init(cryptoCurrency: CryptoCurrency) {
    self.cryptoCurrency = cryptoCurrency
    self.id = cryptoCurrency.id
    self.image = placeholderImage
    self.currentPrice = cryptoCurrency.currentPrice
    self.highestPriceIn24h = cryptoCurrency.highestPriceIn24h
    self.lowestPriceIn24h = cryptoCurrency.lowestPriceIn24h
    self.allTimeHighestPrice = cryptoCurrency.allTimeHighestPrice
    self.allTimeLowestPrice = cryptoCurrency.allTimeLowestPrice
    self.allTimeHighestDate = cryptoCurrency.allTimeHighestDate
    self.allTimeLowestDate = cryptoCurrency.allTimeLowestDate
    self.lastUpdatedDate = cryptoCurrency.lastUpdatedDate
  }
  
  func fetchImage() {
    guard let urlString = cryptoCurrency.imageUrlString, let url = URL(string: urlString) else { return }
    ImageFetcher.shared.load(url: url, placeholderImage: placeholderImage) { [weak self] fetchedImageItem in
      self?.image = fetchedImageItem.image
    }
  }
  
  func cancelFetchingImage() {
    guard let urlString = cryptoCurrency.imageUrlString, let url = URL(string: urlString) else { return }
    ImageFetcher.shared.cancelLoad(url)
  }
  
#if DEBUG
  convenience init() {
    self.init(cryptoCurrency: Self.bitcoinMockModel)
  }
#endif
  
}

struct CryptoCurrencyAdaptor {
  
  static func generateCryptoCurrencyDetailList(from cryptoCurrencies: [CryptoCurrency]) -> [CryptoCurrencyDetail] {
    return cryptoCurrencies.map({ CryptoCurrencyDetail(cryptoCurrency: $0) })
  }
  
}

private extension CryptoCurrencyDetail {
  
  static let bitcoinMockModel: CryptoCurrency = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
    let path = Bundle.main.path(forResource: "Bitcoin", ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    return try! decoder.decode(CryptoCurrency.self, from: data)
  }()
  
}
