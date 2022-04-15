//
//  Session.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import Foundation

public class Session: SessionProtocol {
  
  public let session: URLSession
  
  public init(session: URLSession = .shared) {
    self.session = session
  }
  
  public func dataTask<T: Decodable>( _ request: URLRequest,
                                      dataType: T.Type,
                                      completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
    return session.dataTask(with: request) { [weak self] data, response, error in
      completion(Result<T, Error> {
        guard let self = self else {
          throw NetworkError.operationCancelled
        }
        
        if let requestError = error {
          throw NetworkError.requestFailed(error: requestError)
        }
        
        try self.validate(response: response)
        return try self.decode(data: data, type: dataType)
      })
    }
  }
}

private extension Session {
  func validate(response: URLResponse?) throws {
    guard let httpResponse = response as? HTTPURLResponse else {
      throw NetworkError.unknownStatusCode
    }
    
    if httpResponse.statusCode == NetworkEnvironment.invalidCurrencyErrorCode {
      throw NetworkError.invalidCurrency
    }
    
    if !NetworkEnvironment.successStatusCodeRange.contains(httpResponse.statusCode) {
      throw NetworkError.unexpectedStatusCode(code: httpResponse.statusCode)
    }
  }
  
  func decode<T: Decodable>(data: Data?, type: T.Type) throws -> T {
    guard let data = data, !data.isEmpty else {
      throw NetworkError.contentEmptyData
    }
    
    do {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
      return try decoder.decode(type, from: data)
    } catch {
      throw NetworkError.contentDecoding(error: error)
    }
  }
}


extension JSONDecoder.DateDecodingStrategy {
  static let iso8601withFractionalSeconds = custom {
    let container = try $0.singleValueContainer()
    let string = try container.decode(String.self)
    guard let date = Formatter.iso8601withFractionalSeconds.date(from: string) else {
      throw DecodingError.dataCorruptedError(in: container,
                                             debugDescription: "Invalid date: " + string)
    }
    return date
  }
}

extension Formatter {
  static let iso8601withFractionalSeconds: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    return formatter
  }()
}
