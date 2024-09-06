//
//  SearchView.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import SwiftUI

struct SearchView: View {
  @ObservedObject var presenter: SearchPresenter

  var body: some View {
    VStack {
      Spacer()
      ZStack {
        if presenter.isLoading {
          loadingIndicator
        } else if presenter.title.isEmpty {
          emptyTitle
        } else if presenter.games.isEmpty {
          emptyGames
        } else if presenter.isError {
          errorIndicator
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(
              self.presenter.games,
              id: \.id
            ) { game in
              ZStack {
                self.presenter.linkBuilder(for: game) {
                  GameRow(game: game)
                }.buttonStyle(PlainButtonStyle())
              }.padding(8)
            }
          }
        }
      }.searchable(text: $presenter.title)
        .onSubmit(of: .search, presenter.searchGame)
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
}
