//
//  SongAndAlbum.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/22.
//

import SwiftUI
struct Artist: Hashable, Codable, Equatable {
  var name: String
  var image: Data
  var albums: [Album]?

  var getImage: Image {
    if let uiImage = UIImage(data: self.image) {
      return Image(uiImage: uiImage)
    } else {
      return Image("image1")
    }
  }

  static let example = Artist(name: "Some badass artist", image: Data(), albums: [Album.example, Album.example, Album.example])
}

struct Album: Hashable, Codable {
//  var id = UUID()
  var artist: String
  var title: String
  var tracks: Int
  var image: Data
  var songs: [Song]
  
  subscript(index: Int) -> Song {
//    let target = songs.first { song in
//      song.track == index
//    }
    var position = index
    if index > 0 {
      position -= 1
    } else {
      position = songs.count - 1
    }
    return songs[position]
  }

  var getImage: Image {
    if let uiImage = UIImage(data: self.image) {
      return Image(uiImage: uiImage)
    } else {
      return Image("image1")
    }
  }

  static let example =
    Album(
      artist: "aaaa", title: "title_title_title_title", tracks: 2, image: Data(),
      songs: [Song(title: "name1", duration: 30.11, track: 2, uri: "some/url"),
              Song(title: "name2", duration: 30.11, track: 2, uri: "some/url")])
}

struct Song: Hashable, Codable {
  var title: String
  var duration: Double
  var track: Int
  var uri: String

  static let example = Song(title: "ttt", duration: 11.1, track: 1, uri: "url/")
}
