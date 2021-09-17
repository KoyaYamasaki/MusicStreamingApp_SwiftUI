//
//  Player.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/17.
//

import SwiftUI

struct Player: View {
  var album: Album = Album.example
  @Binding var expand: Bool

  var body: some View {
    if album != nil {
      if expand {
        PlayerView(vm: PlayerViewModel(currentSong: Song.example, album: Album.example))
      } else {
        Miniplayer(expand: $expand)
      }
    }
  }
}

struct Player_Previews: PreviewProvider {
  static var previews: some View {
    Player(expand: .constant(false))
  }
}
