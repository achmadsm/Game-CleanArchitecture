//
//  GameRow.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import CachedAsyncImage
import SwiftUI

struct GameRow: View {
  var game: GameModel
  var body: some View {
    VStack {
      imageGame
      content
    }
    .frame(width: UIScreen.main.bounds.width - 32, height: 200)
    .background(Color.black.opacity(0.6))
    .cornerRadius(18)
  }
}

extension GameRow {
  var imageGame: some View {
    CachedAsyncImage(url: URL(string: game.image)) { image in
      image
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(height: 150)
        .clipped()
    } placeholder: {
      ProgressView()
    }.frame(height: 150)
  }

  var content: some View {
    Text(game.name)
      .font(.title3)
      .bold()
      .foregroundStyle(Color.white)
      .padding([.leading, .bottom], 16)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct GameRow_Previews: PreviewProvider {
  static var previews: some View {
    let game = GameModel(
      id: 1,
      name: "Grand Theft Auto V",
      released: "2013-09-17",
      image: "https://media.rawg.io/media/games/b11/b115b2bc6a5957a917bc7601f4abdda2.jpg",
      rating: 4.47,
      descriptionRaw: "Lorem ipsum dolor sit amet"
    )
    return GameRow(game: game)
  }
}
