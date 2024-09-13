//
//  HomeRouter.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import Core
import GamePackage
import SwiftUI

class HomeRouter {
  func makeGameView(for game: GameModel) -> some View {
    let useCase: Interactor<
      Int,
      GameModel,
      GetGameRepository<
        GetGamesLocalDataSource,
        GetGameRemoteDataSource,
        GameTransformer>
    > = Injection().provideGame()

    let favoriteUseCase: Interactor<
      Int,
      GameModel,
      UpdateFavoriteGameRepository<
        GetFavoriteGamesLocalDataSource,
        GameTransformer>
    > = Injection().provideUpdateFavorite()

    let presenter = GamePresenter(gameUseCase: useCase, favoriteUseCase: favoriteUseCase)

    return DetailView(presenter: presenter, game: game)
  }
}
