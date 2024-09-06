//
//  GameRepository.swift
//  Game
//
//  Created by + on 2/26/1446 AH.
//

import Combine
import Foundation

protocol GameRepositoryProtocol {
  func getGames() -> AnyPublisher<[GameModel], Error>
  func getGame(by gameId: Int) -> AnyPublisher<GameModel, Error>
  func searchGame(by title: String) -> AnyPublisher<[GameModel], Error>
  func getFavoriteGames() -> AnyPublisher<[GameModel], Error>
  func updateFavoriteGame(by gameId: Int) -> AnyPublisher<GameModel, Error>
}

final class GameRepository: NSObject {
  typealias GameInstance = (LocalDataSource, RemoteDataSource) -> GameRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let local: LocalDataSource

  private init(local: LocalDataSource, remote: RemoteDataSource) {
    self.local = local
    self.remote = remote
  }

  static let sharedInstance: GameInstance = { localRepo, remoteRepo in
    GameRepository(local: localRepo, remote: remoteRepo)
  }
}

extension GameRepository: GameRepositoryProtocol {
  func getGames() -> AnyPublisher<[GameModel], Error> {
    return local.getGames()
      .flatMap { result -> AnyPublisher<[GameModel], Error> in
        if result.isEmpty {
          return self.remote.getGames()
            .map { GameMapper.mapGameResponsesToEntities(input: $0) }
            .catch { _ in self.local.getGames() }
            .flatMap { self.local.addGames(from: $0) }
            .filter { $0 }
            .flatMap { _ in self.local.getGames()
              .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
            }
            .eraseToAnyPublisher()
        } else {
          return self.local.getGames()
            .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func getGame(
    by gameId: Int
  ) -> AnyPublisher<GameModel, Error> {
    return local.getGame(by: gameId)
      .flatMap { result -> AnyPublisher<GameModel, Error> in
        if result.name.isEmpty {
          return self.remote.getGame(by: gameId)
            .map { GameMapper.mapDetailGameResponseToEntity(by: gameId, input: $0) }
            .catch { _ in self.local.getGame(by: gameId) }
            .flatMap { self.local.updateGame(by: gameId, game: $0) }
            .filter { $0 }
            .flatMap { _ in self.local.getGame(by: gameId)
              .map { GameMapper.mapDetailGameEntityToDomain(input: $0) }
            }.eraseToAnyPublisher()
        } else {
          return self.local.getGame(by: gameId)
            .map { GameMapper.mapDetailGameEntityToDomain(input: $0) }
            .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }

  func searchGame(
    by title: String
  ) -> AnyPublisher<[GameModel], Error> {
    return remote.searchGame(by: title)
      .map { GameMapper.mapDetailGameResponseToEntity(input: $0) }
      .catch { _ in self.local.getGamesBy(title) }
      .flatMap { responses in
        self.local.getGamesBy(title)
          .flatMap { local -> AnyPublisher<[GameModel], Error> in
            if responses.count > local.count {
              return self.local.addGamesBy(title, from: responses)
                .filter { $0 }
                .flatMap { _ in self.local.getGamesBy(title)
                  .map { GameMapper.mapDetailGameEntityToDomains(input: $0) }
                }.eraseToAnyPublisher()
            } else {
              return self.local.getGamesBy(title)
                .map { GameMapper.mapDetailGameEntityToDomains(input: $0) }
                .eraseToAnyPublisher()
            }
          }
      }.eraseToAnyPublisher()
  }

  func getFavoriteGames() -> AnyPublisher<[GameModel], Error> {
    return local.getFavoriteGames()
      .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
      .eraseToAnyPublisher()
  }

  func updateFavoriteGame(
    by gameId: Int
  ) -> AnyPublisher<GameModel, Error> {
    return local.updateFavoriteGame(by: gameId)
      .map { GameMapper.mapDetailGameEntityToDomain(input: $0) }
      .eraseToAnyPublisher()
  }
}
