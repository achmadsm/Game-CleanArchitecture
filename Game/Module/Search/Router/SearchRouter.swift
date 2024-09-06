//
//  SearchRouter.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import SwiftUI

class SearchRouter {
  func makeGameView(for game: GameModel) -> some View {
    let gameUseCase = Injection().provideDetail(game: game)
    let presenter = DetailPresenter(gameUseCase: gameUseCase)
    return DetailView(presenter: presenter)
  }
}
