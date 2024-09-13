//
//  ContentView.swift
//  Game
//
//  Created by + on 2/24/1446 AH.
//

import Core
import GamePackage
import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: GetListPresenter<Any, GameModel,
    Interactor<Any, [GameModel],
      GetGamesRepository<GetGamesLocalDataSource, GetGamesRemoteDataSource,
        GamesTransformer>>>
  @EnvironmentObject var searchPresenter: SearchPresenter<GameModel,
    Interactor<String, [GameModel],
      SearchGamesRepository<GetGamesRemoteDataSource,
        GamesTransformer>>>
  @EnvironmentObject var favoritePresenter: GetListPresenter<Int, GameModel,
    Interactor<Int, [GameModel],
      GetFavoriteGamesRepository<GetFavoriteGamesLocalDataSource,
        GamesTransformer>>>

  var body: some View {
    TabView {
      NavigationStack {
        HomeView(presenter: homePresenter)
      }.tabItem {
        TabItem(imageName: "house", title: "Home")
      }

      NavigationStack {
        SearchView(presenter: searchPresenter)
      }.tabItem {
        TabItem(imageName: "magnifyingglass", title: "Search")
      }

      NavigationStack {
        FavoriteView(presenter: favoritePresenter)
      }.tabItem {
        TabItem(imageName: "heart", title: "Favorite")
      }

      NavigationStack {
        ProfileView()
      }.tabItem {
        TabItem(imageName: "person", title: "Profile")
      }
    }
  }
}
