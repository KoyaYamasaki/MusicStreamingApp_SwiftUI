//
//  MainView.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/17.
//

import SwiftUI

struct MainView: View {
  @ObservedObject var lsArtists: LSArtists
//  @State private var vm: PlayerViewModel? = nil
  @State private var expand = false
    var body: some View {
      ZStack {
        ContentView(lsArtists: lsArtists, expand: $expand)
//        if vm != nil {
        VStack {
          Spacer()
          Player(expand: $expand)
            .background(Color.black.opacity(0.5))
          }
        }
//        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
      MainView(lsArtists: LSArtists())
    }
}
