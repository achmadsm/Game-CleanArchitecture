//
//  HomeView.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var presenter: HomePresenter

  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else if presenter.games.isEmpty {
        emptyGames
      } else {
        content
      }
    }.onAppear {
      if self.presenter.games.isEmpty {
        self.presenter.getGames()
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
}
