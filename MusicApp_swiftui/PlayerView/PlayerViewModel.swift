//
//  PlayerViewModel.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/15.
//

import Combine
import AVFoundation

class PlayerViewModel: ObservableObject {
  @Published var currentSong: Song?
  var album: Album?
  let player = CustomPlayer()
  let publisher = PassthroughSubject<Void, Never>()

  init(currentSong: Song? = nil, album: Album? = nil) {
//    print("PlayerViewModel init")
    self.currentSong = currentSong
    self.album = album
  }

  func setPlayerItem(song: Song) {
    let playerItem = currentPlayerItem
    self.player.replaceCurrentItem(with: playerItem)
    self.setObserver(player: self.player)
  }

  var currentPlayerItem: AVPlayerItem {
    let songUrl = self.currentSong!.uri.replacingOccurrences(of: " ", with: "%20")
    let url = URL(string: localServerURL + songUrl)
    return AVPlayerItem(url: url!)
  }

  func setObserver(player: AVPlayer) {
    let item = player.currentItem
    var cancellable: AnyCancellable?
    cancellable = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime, object: item).sink { [weak self] change in
      self?.publisher.send()
//      self?.currentSong = self!.album.songs.first(where: {$0.track == (self!.currentSong.track+1)})!
      print("after publisher.send()")
      cancellable?.cancel()
    }
  }
}
