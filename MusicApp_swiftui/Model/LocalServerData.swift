//
//  LocalServerData.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/22.
//

import Foundation

class LocalServerData: ObservableObject {
  @Published var albums = [Album]()

  func fetchLocalServerData() {
    let url = URL(string: "http://192.168.0.12:3005/list")!
    let request = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data else { return }
      do {
        let object = try JSONSerialization.jsonObject(with: data, options: [])
        print(object)
      } catch let error {
        print(error)
      }
    }
    task.resume()
  }

}
