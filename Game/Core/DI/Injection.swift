//
//  Injection.swift
//  Game
//
//  Created by + on 2/26/1446 AH.
//

import Core
import Foundation
import GamePackage
import RealmSwift

final class Injection: NSObject {
  private let realm = try? Realm()

  func provideGames<U: UseCase>() -> U where U.Request == Any, U.Response == [GameModel] {
    let local = GetGamesLocalDataSource(realm: realm!)

    let remote = GetGamesRemoteDataSource(endpoint: Endpoints.Gets.games.url)

    let mapper = GamesTransformer()

    let repository = GetGamesRepository(
      localDataSource: local,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideGame<U: UseCase>() -> U where U.Request == Int, U.Response == GameModel {
    let local = GetGamesLocalDataSource(realm: realm!)

    let remote = GetGameRemoteDataSource(endpoint: Endpoints.Gets.game.url)

    let mapper = GameTransformer()

    let repository = GetGameRepository(
      localDataSource: local,
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideSearch<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {
    let remote = GetGamesRemoteDataSource(endpoint: Endpoints.Gets.search.url)

    let mapper = GamesTransformer()

    let repository = SearchGamesRepository(
      remoteDataSource: remote,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideFavorite<U: UseCase>() -> U where U.Request == Int, U.Response == [GameModel] {
    let local = GetFavoriteGamesLocalDataSource(realm: realm!)

    let mapper = GamesTransformer()

    let repository = GetFavoriteGamesRepository(
      localDataSource: local,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }

  func provideUpdateFavorite<U: UseCase>() -> U where U.Request == Int, U.Response == GameModel {
    let local = GetFavoriteGamesLocalDataSource(realm: realm!)

    let mapper = GameTransformer()

    let repository = UpdateFavoriteGameRepository(
      localDataSource: local,
      mapper: mapper)

    return Interactor(repository: repository) as! U
  }
}
