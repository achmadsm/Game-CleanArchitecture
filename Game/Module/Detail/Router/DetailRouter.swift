//
//  DetailRouter.swift
//  Game
//
//  Created by + on 2/29/1446 AH.
//

import SwiftUI

class DetailRouter {

  func makeGameView(for game: GameModel) -> some View {
    let mealUseCase = Injection.init().provideMeal(meal: meal)
    let presenter = MealPresenter(mealUseCase: mealUseCase)
    return MealView(presenter: presenter)
  }

}
