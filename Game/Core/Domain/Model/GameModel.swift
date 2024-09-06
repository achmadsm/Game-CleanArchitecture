//
//  GameModel.swift
//  Game
//
//  Created by + on 2/25/1446 AH.
//

struct GameModel: Equatable, Identifiable {
  let id: Int
  let name, released: String
  let image: String
  let rating: Double
  let descriptionRaw: String
  var favorite: Bool = false
}
