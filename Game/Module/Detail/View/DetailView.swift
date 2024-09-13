//
//  GameView.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import CachedAsyncImage
import Core
import GamePackage
import SwiftUI

struct DetailView: View {
  @State private var showingAlert = false

  @ObservedObject var presenter: GamePresenter<Interactor<Int, GameModel, GetGameRepository<GetGamesLocalDataSource, GetGameRemoteDataSource, GameTransformer>>,
    Interactor<Int, GameModel, UpdateFavoriteGameRepository<GetFavoriteGamesLocalDataSource, GameTransformer>>>

  var game: GameModel

  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else {
        ScrollView(.vertical) {
          VStack {
            imageGame
            content
          }.padding()
        }
      }
    }.onAppear {
      self.presenter.getGame(request: game.id)
    }.alert(isPresented: $showingAlert) {
      Alert(
        title: Text("Oops!"),
        message: Text("Something wrong!"),
        dismissButton: .default(Text("OK"))
      )
    }.navigationBarTitle(
      Text(""),
      displayMode: .inline
    )
  }
}

extension DetailView {
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

  var content: some View {
    return VStack(alignment: .leading) {
      HStack(alignment: .firstTextBaseline) {
        Text(self.presenter.item?.name ?? "")
          .font(/*@START_MENU_TOKEN@*/ .title/*@END_MENU_TOKEN@*/).bold()

        Spacer()
        if presenter.item?.favorite == true {
          CustomIcon(
            imageName: "heart.fill",
            title: "Favorited"
          )
          .onTapGesture { self.presenter.updateFavoriteGame(request: game.id) }
        } else {
          CustomIcon(
            imageName: "heart",
            title: "Favorite"
          )
          .onTapGesture { self.presenter.updateFavoriteGame(request: game.id) }
        }
      }

      Spacer()
      Text(self.presenter.item?.released ?? "")

      Spacer()
      Text(String(self.presenter.item?.rating ?? 0.0))

      Spacer()
      Text(self.presenter.item?.descriptionRaw ?? "")
        .font(.body)
    }
  }

  var imageGame: some View {
    CachedAsyncImage(url: URL(string: self.presenter.item?.image ?? "")) { image in
      image.resizable()
    } placeholder: {
      ProgressView()
    }.scaledToFill()
      .frame(width: UIScreen.main.bounds.width - 32, height: 250.0, alignment: .center)
      .cornerRadius(12)
  }
}
