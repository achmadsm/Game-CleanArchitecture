//
//  CustomeError+Ext.swift
//  Game
//
//  Created by + on 2/24/1446 AH.
//

import Foundation

enum URLError: LocalizedError {
  case invalidResponse
  case addressUnreachable(URL)

  var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case let .addressUnreachable(url): return "\(url.absoluteString) is unreachable."
    }
  }
}

enum DatabaseError: LocalizedError {
  case invalidInstance
  case requestFailed

  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }
}
