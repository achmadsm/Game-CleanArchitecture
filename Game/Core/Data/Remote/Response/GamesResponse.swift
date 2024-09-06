//
//  GamesReponses.swift
//  Game
//
//  Created by + on 2/24/1446 AH.
//

struct GamesResponse: Decodable {
  let results: [GameResponse]
}

struct GameResponse: Decodable {
  let id: Int
  let name, released: String
  let image: String
  let rating: Double
  let descriptionRaw: String

  enum CodingKeys: String, CodingKey {
    case id, name, released
    case image = "background_image"
    case rating
    case descriptionRaw = "description_raw"
  }
}
