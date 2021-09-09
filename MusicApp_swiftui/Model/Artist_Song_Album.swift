//
//  SongAndAlbum.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/22.
//

import Foundation

struct Artist: Hashable {
  var name: String
  var albums: [Album]

  static let example = Artist(name: "Some badass artist", albums: [Album.example])
}

struct Album: Hashable {
  var id = UUID()
  var name: String
  var image: String
  var songs: [Song]
  
  subscript(index: Int) -> Song {
    var position = index
    if index > 0 {
      position -= 1
    } else {
      position = songs.count - 1
    }
    return songs[position]
  }
  
  static let example =
    Album(
      name: "Album 1", image: "image1",
      songs: [Song(trackNumber: 1, name: "Song 1", time: "2:36", url: ""),
              Song(trackNumber: 2, name: "Song 2", time: "2:36", url: ""),
              Song(trackNumber: 3, name: "Song 3", time: "2:36", url: ""),
              Song(trackNumber: 4, name: "Song 4", time: "2:36", url: "")])
}

struct Song: Hashable {
  var trackNumber: Int
  var name: String
  var time: String
  var url: String

  static let example = Song(trackNumber: 1, name: "Song 1", time: "2:36", url: "")
}
