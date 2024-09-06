//
//  AboutView.swift
//  Game
//
//  Created by + on 3/1/1446 AH.
//

import SwiftUI

struct ProfileView: View {
  var body: some View {
    VStack {
      Image("profile")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 4))
        .shadow(radius: 10)
        .frame(width: 100, height: 100)

      Text("Achmad Syeful M")
        .font(.headline)
        .fontWeight(.bold)
        .padding(.top, 8)
    }
    .padding()
  }
}
