//
//  ThreadSafeDictionary.swift
//  RealTymeCurrencies
//
//  Created by Samet Berberoğlu on 15.04.2022.
//

import Foundation

public class ThreadSafeDictionary<V: Hashable, T: Any>: Collection {
  
  private var dictionary: [V: T]
  private let concurrentQueue = DispatchQueue(label: "CryptoCurrencies.ThreadSafeDictionary", attributes: .concurrent)
  
  public var startIndex: Dictionary<V, T>.Index {
    self.concurrentQueue.sync {
      return self.dictionary.startIndex
    }
  }
  
  public var endIndex: Dictionary<V, T>.Index {
    self.concurrentQueue.sync {
      return self.dictionary.endIndex
    }
  }
  
  public init(dictionary: [V: T] = [V: T]()) {
    self.dictionary = dictionary
  }
  
  public func index(after i: Dictionary<V, T>.Index) -> Dictionary<V, T>.Index {
    self.concurrentQueue.sync {
      return self.dictionary.index(after: i)
    }
  }
  
  public subscript(key: V) -> T? {
    set(newValue) {
      self.concurrentQueue.async(flags: .barrier) { [weak self] in
        self?.dictionary[key] = newValue
      }
    }
    get {
      self.concurrentQueue.sync {
        return self.dictionary[key]
      }
    }
  }
  
  public subscript(index: Dictionary<V, T>.Index) -> Dictionary<V, T>.Element {
    self.concurrentQueue.sync {
      return self.dictionary[index]
    }
  }
  
  public func removeValue(forKey key: V) {
    self.concurrentQueue.async(flags: .barrier) { [weak self] in
      self?.dictionary.removeValue(forKey: key)
    }
  }
  
  public func removeAll() {
    self.concurrentQueue.async(flags: .barrier) { [weak self] in
      self?.dictionary.removeAll()
    }
  }
  
}
