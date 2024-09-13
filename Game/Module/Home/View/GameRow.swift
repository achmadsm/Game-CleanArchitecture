//
//  GameRow.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import CachedAsyncImage
import GamePackage
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
