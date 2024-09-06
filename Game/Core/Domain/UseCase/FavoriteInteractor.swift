//
//  DetailInteractor.swift
//  Game
//
//  Created by + on 2/26/1446 AH.
//

import Combine

protocol FavoriteUseCase {
  func getFavoriteGames() -> AnyPublisher<[GameModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func getFavoriteGames() -> AnyPublisher<[GameModel], Error> {
    return repository.getFavoriteGames()
  }
}
