//
//  LocalServerData.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/22.
//

import SwiftUI

let localServerURL = "http://192.168.0.12:3005/"

class LSAlbums: ObservableObject {
  @Published var data = [Album]()

  func fetchData(for artist: Artist) {
    let url = URL(string: localServerURL + "list/" + artist.name)!
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data else { return }
      do {
        let albums = try JSONDecoder().decode([Album].self, from: data)
        DispatchQueue.main.async {
          self.data = albums
        }
      } catch let error {
        print(error)
      }
    }
    task.resume()
  }
}

class LocalServerData: ObservableObject {
//  @Published var albums = [Album]()
  @Published var artists = [Artist]()

  static let localServerURL = "http://192.168.0.12:3005/"

  func fetchLocalServerData() {
    let url = URL(string: Self.localServerURL + "list")!
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data else { return }
      do {
        let artists = try JSONDecoder().decode([Artist].self, from: data)
        DispatchQueue.main.async {
          self.artists = artists
        }
      } catch let error {
        print(error)
      }
    }
    task.resume()
  }

  subscript(artistName: String) -> Artist {
    return Artist.example
  }
}
