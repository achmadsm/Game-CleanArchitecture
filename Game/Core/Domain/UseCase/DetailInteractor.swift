//
//  GameInteractor.swift
//  Game
//
//  Created by + on 2/26/1446 AH.
//

import Combine

protocol DetailUseCase {
  func getGame() -> AnyPublisher<GameModel, Error>
  func getGame() -> GameModel
  func updateFavoriteGame() -> AnyPublisher<GameModel, Error>
}

class GameInteractor: DetailUseCase {
  private let repository: GameRepositoryProtocol
  private let game: GameModel

  required init(
    repository: GameRepositoryProtocol,
    game: GameModel
  ) {
    self.repository = repository
    self.game = game
  }

  func getGame() -> AnyPublisher<GameModel, Error> {
    return repository.getGame(by: game.id)
  }

  func getGame() -> GameModel {
    return game
  }

  func updateFavoriteGame() -> AnyPublisher<GameModel, Error> {
    return repository.updateFavoriteGame(by: game.id)
  }
}
