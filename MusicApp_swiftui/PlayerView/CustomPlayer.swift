//
//  PlayerFinishObserver.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/13.
//

import Combine
import AVFoundation

class CustomPlayer: AVPlayer {

  let publisher = PassthroughSubject<Void, Never>()

  override init() {
    super.init()
  }

  override func replaceCurrentItem(with item: AVPlayerItem?) {
    super.replaceCurrentItem(with: item)
//    setObserver()
  }
}
