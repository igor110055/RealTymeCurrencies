//
//  RealTymeCurrenciesTests.swift
//  RealTymeCurrenciesTests
//
//  Created by Samet Berberoğlu on 18.04.2022.
//

import XCTest
import Combine
@testable import RealTymeCurrencies

class RealTymeCurrenciesTests: XCTestCase {

  private lazy var cryptocurrencyRepository: CryptocurrenciesRepositoryProtocol = CryptocurrencyRepository(client: self)
  private lazy var cryptocurrencyListViewModel = CryptocurrencyListViewModel(repository: cryptocurrencyRepository)
  private var cancellabes = Set<AnyCancellable>()
  
  private lazy var _urlSession: SessionProtocol = {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockUrlProtocol.self]
    let session = URLSession(configuration: configuration)
    return Session(session: session)
  }()
  
  func testCryptoCurrencies() {
    let data = generateDataFrom(fileName: "CryptoCurrencies")
    let referenceCryptoCurrencies = decoded(dataType: [CryptoCurrency].self, from: data)
    
    let expectation = XCTestExpectation(description: "response")
    cryptocurrencyListViewModel.$datasource.sink { cryptoCurrencies in
      if cryptoCurrencies.count > 0 {
        for index in 0..<cryptoCurrencies.count {
          XCTAssertEqual(cryptoCurrencies[index].name, referenceCryptoCurrencies[index].name)
          XCTAssertEqual(cryptoCurrencies[index].lastUpdatedDateString, referenceCryptoCurrencies[index].lastUpdatedDate?.sb_formattedLongDateString)
          XCTAssertEqual(cryptoCurrencies[index].symbol, referenceCryptoCurrencies[index].symbol)
          XCTAssertEqual(cryptoCurrencies[index].currentPriceString, referenceCryptoCurrencies[index].currentPrice.sb_formattedPriceString)
        }
        expectation.fulfill()
      }
    }.store(in: &cancellabes)
    
    prepareForTestAndLoadData(with: data)
    wait(for: [expectation], timeout: 20.0)
  }
  
  //MARK: Helpers
  private func prepareForTestAndLoadData(with referenceData: Data) {
    MockUrlProtocol.testSamples = [service.urlRequest.url: referenceData]
    (cryptocurrencyListViewModel.repository as? CryptocurrencyRepository)?.client = self
    cryptocurrencyListViewModel.loadData()
  }
  
  private func generateDataFrom(fileName: String) -> Data {
    let path = Bundle(for: Self.self).path(forResource: fileName, ofType: "json")
    XCTAssertNotNil(path, "the file can not be found in the current bundle")
    let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
    XCTAssertNotNil(data, "data conversion failure")
    return data!
  }
  
  private func decoded<T: Decodable>(dataType: T.Type, from data: Data) -> T {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
    let decodedObject = try? decoder.decode(dataType, from: data)
    XCTAssertNotNil(decodedObject, "decodingError")
    return decodedObject!
  }

}

extension RealTymeCurrenciesTests: NetworkProviderProtocol {
  
  var urlSession: SessionProtocol {
    return _urlSession
  }
  
  var service: NetworkService {
    return CryptocurrenciesService(fiatCurrency: "USD")
  }
  
}
