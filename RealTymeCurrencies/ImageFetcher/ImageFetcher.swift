//
//  ImageFetcher.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import UIKit

public class ImageFetcher {
  
  public typealias CompletionHandler = (ImageItem) -> Void
  
  public static let shared = ImageFetcher()
  
  private let urlSession: URLSession
  private let cachedItems = NSCache<NSURL, ImageItem>()
  
  private let loadingResponses = ThreadSafeDictionary<NSURL, [CompletionHandler]>()
  private let runningRequests = ThreadSafeDictionary<NSURL, URLSessionDataTask>()
  
  public final func imageItem(url: NSURL) -> ImageItem? {
    return cachedItems.object(forKey: url)
  }
  
  public init(session: URLSession = URLSession.shared) {
    self.urlSession = session
  }
  
  public final func load(url: URL?,
                         placeholderImage: UIImage,
                         queue: DispatchQueue = .main,
                         completion: @escaping CompletionHandler) {
    
    guard let url = url else { return }
    let nsUrl = url as NSURL
    
    if let cachedItem = imageItem(url: nsUrl) {
      queue.async {
        completion(cachedItem)
      }
      return
    }
    
    if loadingResponses[nsUrl] != nil {
      loadingResponses[nsUrl]?.append(completion)
    } else {
      loadingResponses[nsUrl] = [completion]
    }
    
    let task = urlSession.dataTask(with: url as URL) { [weak self] data, _, error in
      guard let self = self else { return }
      defer {
        self.runningRequests.removeValue(forKey: nsUrl)
        self.loadingResponses[nsUrl]?.removeAll()
      }
      
      guard let responseData = data,
            let image = UIImage(data: responseData),
            let blocks = self.loadingResponses[nsUrl],
            error == nil
      else {
        queue.async {
          let imageItem = ImageItem(image: placeholderImage, url: url)
          completion(imageItem)
        }
        return
      }
      
      let imageItem = ImageItem(image: image, url: url)
      self.cachedItems.setObject(imageItem, forKey: nsUrl)
      
      for block in blocks {
        queue.async {
          block(imageItem)
        }
      }
    }
    
    task.resume()
    runningRequests[nsUrl] = task
  }
  
  public func cancelLoad(_ url: URL?) {
    guard let url = url else { return }
    let nsUrl = url as NSURL
    runningRequests[nsUrl]?.cancel()
    runningRequests.removeValue(forKey: nsUrl)
  }
}

