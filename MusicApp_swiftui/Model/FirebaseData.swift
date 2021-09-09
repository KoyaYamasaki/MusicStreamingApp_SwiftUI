//
//  Data.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI
import Firebase

class FirebaseData: ObservableObject {
  @Published var albums = [Album]()
  
  func loadAlbums() {
    Firestore.firestore().collection("albums").getDocuments { (snapshot, error) in
      if error == nil {
        for document in snapshot!.documents {
          let name = document.data()["name"] as? String ?? "error"
          let image = document.data()["image"] as? String ?? "error"
          let songs = document.data()["songs"] as? [String : [String : Any]]
          var songsArray = [Song]()
          if let songs = songs {
            var index = 1
            for song in songs {
              let songName = song.value["name"] as? String ?? "error"
              let songTime = song.value["time"] as? String ?? "error"
              let songUrl = song.value["url"] as? String ?? "error"
              songsArray.append(Song(trackNumber: index, name: songName, time: songTime, url: songUrl))
              index += 1
            }
          }
          self.albums.append(Album(name: name, image: image, songs: songsArray))
        }
      } else {
        print(error?.localizedDescription)
      }
    }
  }
}
