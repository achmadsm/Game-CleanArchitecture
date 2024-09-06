//
//  APICall.swift
//  Game
//
//  Created by + on 2/24/1446 AH.
//

struct API {
  static let baseUrl = "https://rawg-mirror.vercel.app/api/games"
}

protocol Endpoint {
  var url: String { get }
}

enum Endpoints {
  enum Gets: Endpoint {
    case games
    case game
    case search

    public var url: String {
      switch self {
      case .games: return API.baseUrl
      case .game: return "\(API.baseUrl)/"
      case .search: return "\(API.baseUrl)?search="
      }
    }
  }
}
