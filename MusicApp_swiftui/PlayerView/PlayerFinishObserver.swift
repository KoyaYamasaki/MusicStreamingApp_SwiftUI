//
//  PlayerFinishObserver.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/13.
//

import Combine
import AVFoundation

class PlayerFinishedObserver {
  
  let publisher = PassthroughSubject<Void, Never>()
  
  func setObserver(player: AVPlayer) {
    let item = player.currentItem
    
    var cancellable: AnyCancellable?
    cancellable = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime, object: item).sink { [weak self] change in
      self?.publisher.send()
      print("after publisher.send()")
      cancellable?.cancel()
    }
  }
}
