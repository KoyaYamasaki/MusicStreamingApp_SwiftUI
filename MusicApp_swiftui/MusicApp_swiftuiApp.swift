//
//  MusicApp_swiftuiApp.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/08/09.
//

import SwiftUI

@main
struct MusicApp_swiftuiApp: App {
  let localServerData = LocalServerData()

  init() {
    localServerData.fetchLocalServerData()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView(localServerData: localServerData)
    }
  }
}
