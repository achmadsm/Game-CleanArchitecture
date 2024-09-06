//
//  GameApp.swift
//  Game
//
//  Created by + on 2/24/1446 AH.
//

import SwiftUI

@main
struct GameApp: App {
  let homePresenter = HomePresenter(homeUseCase: Injection().provideHome())
  let favoritePresenter = FavoritePresenter(favoriteUseCase: Injection().provideFavorite())
  let searchPresenter = SearchPresenter(searchUseCase: Injection().provideSearch())

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(homePresenter)
        .environmentObject(favoritePresenter)
        .environmentObject(searchPresenter)
    }
  }
}
