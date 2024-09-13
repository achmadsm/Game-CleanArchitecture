//
//  FavoriteView.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import Core
import GamePackage
import SwiftUI

struct FavoriteView: View {
  @ObservedObject var presenter: GetListPresenter<Int, GameModel, Interactor<Int, [GameModel], GetFavoriteGamesRepository<GetFavoriteGamesLocalDataSource, GamesTransformer>>>

  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else if presenter.list.isEmpty {
        emptyFavorites
      } else {
        content
      }
    }.onAppear {
      self.presenter.getList(request: nil)
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
        self.presenter.list,
        id: \.id
      ) { game in
        ZStack {
          self.linkBuilder(for: game) {
            GameRow(game: game)
          }.buttonStyle(PlainButtonStyle())
        }
      }
    }
  }

  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: HomeRouter().makeGameView(for: game)
    ) { content() }
  }
}
