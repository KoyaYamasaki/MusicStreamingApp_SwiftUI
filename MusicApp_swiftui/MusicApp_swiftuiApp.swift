//
//  MusicApp_swiftuiApp.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI
import Firebase
@main
struct MusicApp_swiftuiApp: App {
  let firebaseData = FirebaseData()
  let localServerData = LocalServerData()
  init() {
    FirebaseApp.configure()
//    firebaseData.loadAlbums()
    localServerData.fetchLocalServerData()
  }

  var body: some Scene {
    WindowGroup {
      ContentView(firebaseData: firebaseData, localServerData: localServerData)
    }
  }
}
