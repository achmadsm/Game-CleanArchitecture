//
//  DetailPresenter.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import Combine
import SwiftUI

class DetailPresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let detailUseCase: DetailUseCase

  @Published var game: GameModel
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false

  init(gameUseCase: DetailUseCase) {
    detailUseCase = gameUseCase
    game = gameUseCase.getGame()
  }

  func getGame() {
    isLoading = true
    detailUseCase.getGame()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case let .failure(error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { game in
        self.game = game
      })
      .store(in: &cancellables)
  }

  func updateFavoriteGame() {
    detailUseCase.updateFavoriteGame()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { game in
        self.game = game
      })
      .store(in: &cancellables)
  }
}
