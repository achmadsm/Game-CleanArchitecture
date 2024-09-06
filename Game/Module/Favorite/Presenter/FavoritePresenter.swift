//
//  FavoritePresenter.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import Combine
import SwiftUI

class FavoritePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = FavoriteRouter()
  private let favoriteUseCase: FavoriteUseCase

  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false

  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }

  func getFavoriteGames() {
    isLoading = true
    favoriteUseCase.getFavoriteGames()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case let .failure(error):
          self.errorMessage = error.localizedDescription
          self.isError = true
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { games in
        self.games = games
      })
      .store(in: &cancellables)
  }

  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeGameView(for: game)) { content() }
  }
}
