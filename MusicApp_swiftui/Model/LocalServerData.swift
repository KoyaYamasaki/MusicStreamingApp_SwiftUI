//
//  LocalServerData.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/22.
//

import SwiftUI

class LocalServerData: ObservableObject {
  @Published var albums = [Album]()
  @Published var artists = [Artist]()

  static let localServerURL = "http://192.168.0.12:3005/"

  func fetchLocalServerData() {
    let url = URL(string: Self.localServerURL + "list")!
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data else { return }
      do {        
        self.artists = try JSONDecoder().decode([Artist].self, from: data)
        print(self.artists)
//        self.fetchImages(artist: self.artists.first!)
      } catch let error {
        print(error)
      }
    }
    task.resume()
  }

  func fetchData(for artist: Artist) {
    let url = URL(string: Self.localServerURL + "list/" + artist.name)!
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data else { return }
      do {
        let albums = try JSONDecoder().decode([Album].self, from: data)
//        completionHandler(albums)
        self.updateArtist(artist: artist, albums: albums)
      } catch let error {
        print(error)
      }
    }
    task.resume()
  }

  func fetchImages(artist: Artist) {
    let url = URL(string: Self.localServerURL + "images")!
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data else { return }
      do {
        self.updateArtistImage(artist: artist, data: data)
      } catch let error {
        print(error)
      }
    }
    task.resume()
  }

  func updateArtistImage(artist: Artist, data: Data) {
    for i in 0..<artists.count {
      if artists[i].name == artist.name {
        artists[i].image = data
      }
    }
  }

  func updateArtist(artist: Artist, albums: [Album]) {
    for i in 0..<artists.count {
      if artists[i].name == artist.name {
        artists[i].albums = albums
      }
    }
  }

  subscript(artistName: String) -> Artist {
    return Artist.example
  }
}
