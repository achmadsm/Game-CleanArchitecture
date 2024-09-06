//
//  CustomEmptyView.swift
//  Game
//
//  Created by + on 2/26/1446 AH.
//

import SwiftUI

struct CustomEmptyView: View {
  var image: String
  var title: String

  var body: some View {
    VStack {
      Image(image)
        .resizable()
        .renderingMode(.original)
        .scaledToFit()
        .frame(width: 250)

      Text(title)
        .font(.system(.body, design: .rounded))
    }
  }
}
