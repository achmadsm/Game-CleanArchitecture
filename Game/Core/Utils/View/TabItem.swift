//
//  TabItem.swift
//  Game
//
//  Created by + on 2/26/1446 AH.
//

import SwiftUI

struct TabItem: View {
  var imageName: String
  var title: String
  var body: some View {
    VStack {
      Image(systemName: imageName)
      Text(title)
    }
  }
}
