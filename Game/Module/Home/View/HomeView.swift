//
//  HomeView.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import Core
import GamePackage
import SwiftUI

struct HomeView: View {
  @ObservedObject var presenter: GetListPresenter<Any, GameModel,
    Interactor<Any, [GameModel],
      GetGamesRepository<GetGamesLocalDataSource, GetGamesRemoteDataSource,
        GamesTransformer>>>

  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else if presenter.list.isEmpty {
        emptyGames
      } else {
        content
      }
    }.onAppear {
      if self.presenter.list.isEmpty {
        self.presenter.getList(request: nil)
      }
    }.navigationBarTitle(
      Text("Games Apps"),
      displayMode: .automatic
    )
  }
}

extension HomeView {
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

  var emptyGames: some View {
    CustomEmptyView(
      image: "assetGame",
      title: "Games is empty"
    ).offset(y: 80)
  }

  var content: some View {
    ScrollView(.vertical, showsIndicators: false) {
      ForEach(
        self.presenter.list,
        id: \.id
      ) { game in
        ZStack {
          linkBuilder(for: game) {
            GameRow(game: game)
          }.buttonStyle(PlainButtonStyle())
        }.padding(8)
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
