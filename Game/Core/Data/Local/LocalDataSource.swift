//
//  LocalDataSource.swift
//  Game
//
//  Created by + on 2/25/1446 AH.
//

import Combine
import Foundation
import RealmSwift

protocol LocalDataSourceProtocol: AnyObject {
  func getGame(by gameId: Int) -> AnyPublisher<GameEntity, Error>
  func getGames() -> AnyPublisher<[GameEntity], Error>
  func getGamesBy(_ name: String) -> AnyPublisher<[GameEntity], Error>
  func addGames(from games: [GameEntity]) -> AnyPublisher<Bool, Error>
  func addGamesBy(_ name: String, from games: [GameEntity]) -> AnyPublisher<Bool, Error>
  func updateGame(by gameId: Int, game: GameEntity) -> AnyPublisher<Bool, Error>

  func getFavoriteGames() -> AnyPublisher<[GameEntity], Error>
  func updateFavoriteGame(by gameId: Int) -> AnyPublisher<GameEntity, Error>
}

final class LocalDataSource: NSObject {
  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
    LocalDataSource(realm: realmDatabase)
  }
}

extension LocalDataSource: LocalDataSourceProtocol {
  func getGame(
    by gameId: Int
  ) -> AnyPublisher<GameEntity, Error> {
    return Future<GameEntity, Error> { completion in
      if let realm = self.realm {
        let games: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .filter("id = \(gameId)")
        }()

        guard let game = games.first else {
          completion(.failure(DatabaseError.requestFailed))
          return
        }

        completion(.success(game))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  func getGames() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let games: Results<GameEntity> = {
          realm.objects(GameEntity.self)
        }()
        completion(.success(games.toArray(ofType: GameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  func getGamesBy(
    _ name: String
  ) -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let games: Results<GameEntity> = {
          realm.objects(GameEntity.self)
            .filter("name contains[c] %@", name)
            .sorted(byKeyPath: "name", ascending: true)
        }()
        completion(.success(games.toArray(ofType: GameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  func addGames(
    from games: [GameEntity]
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for game in games {
              realm.add(game, update: .all)
            }
            completion(.success(true))
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  func addGamesBy(
    _ name: String,
    from games: [GameEntity]
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm {
        do {
          try realm.write {
            for game in games {
              if let gameEntity = realm.object(ofType: GameEntity.self, forPrimaryKey: game.name) {
                if gameEntity.name == game.name {
                  game.favorite = gameEntity.favorite
                  realm.add(game, update: .all)
                } else {
                  realm.add(game)
                }
              } else {
                realm.add(game)
              }
            }
          }
          completion(.success(true))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  func updateGame(
    by gameId: Int,
    game: GameEntity
  ) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self.realm, let gameEntity = {
        realm.objects(GameEntity.self).filter("id = \(gameId)")
      }().first {
        do {
          try realm.write {
            gameEntity.setValue(game.name, forKey: "name")
            gameEntity.setValue(game.released, forKey: "released")
            gameEntity.setValue(game.rating, forKey: "rating")
            gameEntity.setValue(game.descriptionRaw, forKey: "descriptionRaw")
            gameEntity.setValue(game.favorite, forKey: "favorite")
          }
          completion(.success(true))

        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  func getFavoriteGames() -> AnyPublisher<[GameEntity], Error> {
    return Future<[GameEntity], Error> { completion in
      if let realm = self.realm {
        let gameEntities = {
          realm.objects(GameEntity.self)
            .filter("favorite = \(true)")
            .sorted(byKeyPath: "name", ascending: true)
        }()
        completion(.success(gameEntities.toArray(ofType: GameEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }

  func updateFavoriteGame(
    by gameId: Int
  ) -> AnyPublisher<GameEntity, Error> {
    return Future<GameEntity, Error> { completion in
      if let realm = self.realm, let gameEntity = {
        realm.objects(GameEntity.self).filter("id = \(gameId)")
      }().first {
        do {
          try realm.write {
            gameEntity.setValue(!gameEntity.favorite, forKey: "favorite")
          }
          completion(.success(gameEntity))
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
}

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
}
