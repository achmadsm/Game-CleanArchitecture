//
//  SearchView.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import Core
import GamePackage
import SwiftUI

struct SearchView: View {
  @ObservedObject var presenter: SearchPresenter<GameModel, Interactor<String, [GameModel], SearchGamesRepository<GetGamesRemoteDataSource, GamesTransformer>>>

  var body: some View {
    VStack {
      Spacer()
      ZStack {
        if presenter.isLoading {
          loadingIndicator
        } else if presenter.keyword.isEmpty {
          emptyTitle
        } else if presenter.list.isEmpty {
          emptyGames
        } else if presenter.isError {
          errorIndicator
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(
              self.presenter.list,
              id: \.id
            ) { game in
              ZStack {
                self.linkBuilder(for: game) {
                  GameRow(game: game)
                }.buttonStyle(PlainButtonStyle())
              }.padding(8)
            }
          }
        }
      }.searchable(text: $presenter.keyword)
        .onSubmit(of: .search, presenter.search)
      Spacer()
    }.navigationBarTitle(
      Text("Search Games"),
      displayMode: .automatic
    )
  }
}

extension SearchView {
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

  var emptyTitle: some View {
    CustomEmptyView(
      image: "assetGame",
      title: "Come on, find your favorite game!"
    ).offset(y: 50)
  }

  var emptyGames: some View {
    CustomEmptyView(
      image: "assetGame",
      title: "Data not found"
    ).offset(y: 80)
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
