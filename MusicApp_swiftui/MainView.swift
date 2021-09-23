//
//  MainView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/17.
//

import SwiftUI

struct MainView: View {
  @ObservedObject var lsArtists: LSArtists
  var vm = PlayerViewModel()
  @State private var playerExpand = true

  var body: some View {
    ZStack {
      ArtistListView(lsArtists: lsArtists, playerExpand: $playerExpand)
        .environmentObject(vm)
      
      VStack {
        Spacer()
        PlayerView(playerExpand: $playerExpand)
          .foregroundColor(.white)
          .background(Color.black.opacity(0.5))
          .environmentObject(vm)
      }
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView(lsArtists: LSArtists())
  }
}
