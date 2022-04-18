//
//  MockUrlProtocol.swift
//  RealTymeCurrenciesTests
//
//  Created by Samet Berberoğlu on 18.04.2022.
//

import Foundation
import XCTest

class MockUrlProtocol: URLProtocol {
  
  static var testSamples = [URL?: Data]()
  
  override class func canInit(with request: URLRequest) -> Bool { true }
  
  override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
  
  override func startLoading() {
    if let data = Self.testSamples[request.url] {
      do {
        let response = try XCTUnwrap(HTTPURLResponse(url: XCTUnwrap(request.url),
                                                     statusCode: 200,
                                                     httpVersion: "HTTP/1.1",
                                                     headerFields: nil))
        client?.urlProtocol(self,
                            didReceive: response,
                            cacheStoragePolicy: .notAllowed)
        
        client?.urlProtocol(self, didLoad: data)
      } catch {
        client?.urlProtocol(self, didFailWithError: error)
      }
    }
    client?.urlProtocolDidFinishLoading(self)
  }
  
  override func stopLoading() { }
  
}
