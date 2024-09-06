//
//  Injection.swift
//  Game
//
//  Created by + on 2/26/1446 AH.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  private func provideRepository() -> GameRepositoryProtocol {
    let realm = try? Realm()

    let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return GameRepository.sharedInstance(local, remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

  func provideDetail(game: GameModel) -> DetailUseCase {
    let repository = provideRepository()
    return GameInteractor(repository: repository, game: game)
  }

  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }

  func provideSearch() -> SearchUseCase {
    let repository = provideRepository()
    return SearchInteractor(repository: repository)
  }
}
