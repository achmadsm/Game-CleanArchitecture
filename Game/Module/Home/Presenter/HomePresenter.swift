//
//  HomePresenter.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import Combine
import SwiftUI

class HomePresenter: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []
  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase

  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false

  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }

  func getGames() {
    isLoading = true
    homeUseCase.getGames()
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
