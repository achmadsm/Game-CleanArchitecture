//
//  HomeInteractor.swift
//  Game
//
//  Created by + on 2/26/1446 AH.
//

import Combine

protocol HomeUseCase {
  func getGames() -> AnyPublisher<[GameModel], Error>
}

class HomeInteractor: HomeUseCase {
  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func getGames() -> AnyPublisher<[GameModel], Error> {
    return repository.getGames()
  }
}
