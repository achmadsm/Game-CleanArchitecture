//
//  SearchInteractor.swift
//  Game
//
//  Created by + on 2/26/1446 AH.
//

import Combine

protocol SearchUseCase {
  func searchGame(by name: String) -> AnyPublisher<[GameModel], Error>
}

class SearchInteractor: SearchUseCase {
  private let repository: GameRepositoryProtocol

  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }

  func searchGame(by name: String) -> AnyPublisher<[GameModel], Error> {
    return repository.searchGame(by: name)
  }
}
