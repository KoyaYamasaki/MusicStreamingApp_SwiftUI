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
  @State private var expand = true
    var body: some View {
      ZStack {
        ContentView(lsArtists: lsArtists, expand: $expand)
          .environmentObject(vm)
//        if vm != nil {
        VStack {
          Spacer()
          Player(expand: $expand)
            .foregroundColor(.white)
            .background(Color.black.opacity(0.5))
            .environmentObject(vm)
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
