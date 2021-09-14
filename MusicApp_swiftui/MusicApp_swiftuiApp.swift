//
//  MusicApp_swiftuiApp.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI

@main
struct MusicApp_swiftuiApp: App {
  let lsArtists = LSArtists()

  init() {
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    lsArtists.fetchData()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView(lsArtists: lsArtists)
    }
  }
}
