//
//  PlayerViewModel.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/15.
//

import Foundation

class PlayerViewModel: ObservableObject {
  @Published var currentSong: Song
  let album: Album

  init(currentSong: Song, album: Album) {
    self.currentSong = currentSong
    self.album = album
  }
}
