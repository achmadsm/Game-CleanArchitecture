//
//  RemoteDataSource.swift
//  Game
//
//  Created by + on 2/24/1446 AH.
//

import Alamofire
import Combine
import Foundation

protocol RemoteDataSourceProtocol: AnyObject {
  func getGames() -> AnyPublisher<[GameResponse], Error>
  func getGame(by id: Int) -> AnyPublisher<GameResponse, Error>
  func searchGame(by name: String) -> AnyPublisher<[GameResponse], Error>
}

final class RemoteDataSource: NSObject {
  override private init() { }

  static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
  func getGames() -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.games.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: GamesResponse.self) { response in
            switch response.result {
            case let .success(value):
              completion(.success(value.results))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }

  func getGame(
    by id: Int
  ) -> AnyPublisher<GameResponse, Error> {
    return Future<GameResponse, Error> { completion in
      if let url = URL(string: Endpoints.Gets.game.url + String(id)) {
        AF.request(url)
          .validate()
          .responseDecodable(of: GamesResponse.self) { response in
            switch response.result {
            case let .success(value):
              completion(.success(value.results[0]))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }

  func searchGame(
    by name: String
  ) -> AnyPublisher<[GameResponse], Error> {
    return Future<[GameResponse], Error> { completion in
      if let url = URL(string: Endpoints.Gets.search.url + name) {
        AF.request(url)
          .validate()
          .responseDecodable(of: GamesResponse.self) { response in
            switch response.result {
            case let .success(value):
              completion(.success(value.results))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
