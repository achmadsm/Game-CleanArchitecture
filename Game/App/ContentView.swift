//
//  ContentView.swift
//  Game
//
//  Created by + on 2/24/1446 AH.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var homePresenter: HomePresenter
  @EnvironmentObject var favoritePresenter: FavoritePresenter
  @EnvironmentObject var searchPresenter: SearchPresenter

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
