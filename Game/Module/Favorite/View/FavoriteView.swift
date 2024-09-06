//
//  FavoriteView.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import SwiftUI

struct FavoriteView: View {
  @ObservedObject var presenter: FavoritePresenter

  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else if presenter.games.isEmpty {
        emptyFavorites
      } else {
        content
      }
    }.onAppear {
      self.presenter.getFavoriteGames()
    }.navigationBarTitle(
      Text("Favorite Games"),
      displayMode: .automatic
    )
  }
}

extension FavoriteView {
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ProgressView()
    }
  }

  var errorIndicator: some View {
    CustomEmptyView(
      image: "assetGame",
      title: presenter.errorMessage
    ).offset(y: 80)
  }

  var emptyFavorites: some View {
    CustomEmptyView(
      image: "assetGame",
      title: "Your favorite is empty"
    ).offset(y: 80)
  }

  var content: some View {
    ScrollView(
      .vertical,
      showsIndicators: false
    ) {
      ForEach(
        self.presenter.games,
        id: \.id
      ) { game in
        ZStack {
          self.presenter.linkBuilder(for: game) {
            GameRow(game: game)
          }.buttonStyle(PlainButtonStyle())
        }
      }
    }
  }
}
