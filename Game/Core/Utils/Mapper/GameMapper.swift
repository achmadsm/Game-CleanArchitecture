//
//  GameMapper.swift
//  Game
//
//  Created by + on 2/26/1446 AH.
//

final class GameMapper {
  static func mapGameResponsesToEntities(
    input gameResponses: [GameResponse]
  ) -> [GameEntity] {
    return gameResponses.map { result in
      let newGame = GameEntity()
      newGame.id = result.id
      newGame.name = result.name
      newGame.released = result.released
      newGame.image = result.image
      newGame.rating = result.rating
      newGame.descriptionRaw = result.descriptionRaw
      return newGame
    }
  }

  static func mapGameResponsesToDomains(
    input gameResponses: [GameResponse]
  ) -> [GameModel] {
    return gameResponses.map { result in
      let newGame = GameModel(
        id: result.id,
        name: result.name,
        released: result.released,
        image: result.image,
        rating: result.rating,
        descriptionRaw: result.descriptionRaw
      )
      return newGame
    }
  }

  static func mapGameEntitiesToDomains(
    input gameEntities: [GameEntity]
  ) -> [GameModel] {
    return gameEntities.map { result in
      GameModel(
        id: result.id,
        name: result.name,
        released: result.released,
        image: result.image,
        rating: result.rating,
        descriptionRaw: result.descriptionRaw,
        favorite: result.favorite
      )
    }
  }

  static func mapDetailGameEntityToDomain(
    input gameEntity: GameEntity
  ) -> GameModel {
    return GameModel(
      id: gameEntity.id,
      name: gameEntity.name,
      released: gameEntity.released,
      image: gameEntity.image,
      rating: gameEntity.rating,
      descriptionRaw: gameEntity.descriptionRaw,
      favorite: gameEntity.favorite
    )
  }

  static func mapDetailGameEntityToDomains(
    input gameEntities: [GameEntity]
  ) -> [GameModel] {
    return gameEntities.map { result in
      GameModel(
        id: result.id,
        name: result.name,
        released: result.released,
        image: result.image,
        rating: result.rating,
        descriptionRaw: result.descriptionRaw,
        favorite: result.favorite
      )
    }
  }

  static func mapDetailGameResponseToEntity(
    by gameId: Int,
    input gameResponse: GameResponse
  ) -> GameEntity {
    let gameEntity = GameEntity()
    gameEntity.id = gameResponse.id
    gameEntity.name = gameResponse.name
    gameEntity.released = gameResponse.released
    gameEntity.image = gameResponse.image
    gameEntity.rating = gameResponse.rating
    gameEntity.descriptionRaw = gameResponse.descriptionRaw
    return gameEntity
  }

  static func mapDetailGameResponseToEntity(
    input gameResponse: [GameResponse]
  ) -> [GameEntity] {
    return gameResponse.map { result in
      let gameEntity = GameEntity()
      gameEntity.id = result.id
      gameEntity.name = result.name
      gameEntity.released = result.released
      gameEntity.image = result.image
      gameEntity.rating = result.rating
      gameEntity.descriptionRaw = result.descriptionRaw
      return gameEntity
    }
  }
}
