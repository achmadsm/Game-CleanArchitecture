//
//  CustomIcon.swift
//  Game
//
//  Created by + on 2/26/1446 AH.
//

import SwiftUI

struct CustomIcon: View {
  var imageName: String
  var title: String

  var body: some View {
    Image(systemName: imageName)
      .font(.system(size: 28))
      .foregroundColor(.red)
  }
}
