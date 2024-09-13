//
//  GameApp.swift
//  Game
//
//  Created by + on 2/24/1446 AH.
//

import Core
import GamePackage
import SwiftUI

let injection = Injection()

let homeUseCase: Interactor<
  Any,
  [GameModel],
  GetGamesRepository<
    GetGamesLocalDataSource,
    GetGamesRemoteDataSource,
    GamesTransformer>
> = injection.provideGames()

let searchUseCase: Interactor<
  String,
  [GameModel],
  SearchGamesRepository<
    GetGamesRemoteDataSource,
    GamesTransformer>
> = injection.provideSearch()

let favoriteUseCase: Interactor<
  Int,
  [GameModel],
  GetFavoriteGamesRepository<
    GetFavoriteGamesLocalDataSource,
    GamesTransformer>
> = injection.provideFavorite()

@main
struct GameApp: App {
  let homePresenter = GetListPresenter(useCase: homeUseCase)
  let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
  let searchPresenter = SearchPresenter(useCase: searchUseCase)

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(favoritePresenter)
        .environmentObject(searchPresenter)
    }
  }
}
