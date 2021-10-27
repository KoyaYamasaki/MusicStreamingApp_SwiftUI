//
//  PlayerViewModel.swift
//  MusicApp_swiftui
//
//  Created by 山崎宏哉 on 2021/09/15.
//

import Combine
import MediaPlayer

enum PlayerControl {
  case play
  case pause
  case next
  case previous
}

class PlayerViewModel: ObservableObject {
  @Published var currentSong: Song?
  {
    didSet {
      self.pauseAndChangeFlag()
      self.setPlayerItem(song: currentSong!)
      self.setSessionActive()
      self.playAndChangeFlag()
      self.setupLockScreenController()
    }
  }
  @Published var isPlaying: Bool = true

  var album: Album?
  let player = AVPlayer()
  let publisher = PassthroughSubject<Void, Never>()
  let lockScreenController: LockScreenController

  init(currentSong: Song? = nil, album: Album? = nil) {

    self.currentSong = currentSong
    self.album = album
    self.lockScreenController = LockScreenController(player: player)
    self.lockScreenController.setupRemoteTransportControls(playControl: onReceivePlayerControl)
  }

  func setPlayerItem(song: Song) {
    let playerItem = currentPlayerItem
    self.player.replaceCurrentItem(with: playerItem)
    self.setObserver(player: self.player)
  }

  func setupLockScreenController() {
    self.lockScreenController.setupNowPlaying()
    self.lockScreenController.updateNowPlaying()
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
      print("after publisher.send()")
      cancellable?.cancel()
    }
  }

  func onReceivePlayerControl(_ playerControl: PlayerControl) {

    switch playerControl {
    case .play:
      playAndChangeFlag()
    case .pause:
      pauseAndChangeFlag()
    case .next:
      next()
    case .previous:
      previous()
    }
  }

  func setSessionActive() {
    do {
      try AVAudioSession.sharedInstance().setActive(true)
    } catch {
      print(error)
    }
  }

  func playAndChangeFlag() {
    self.player.play()
    self.isPlaying = true
  }

  func pauseAndChangeFlag() {
    self.player.pause()
    self.isPlaying = false
  }

  func next() {
    print("next in")
    if currentSong!.track < self.album!.songs.count {
      player.pause()
      currentSong = self.album!.songs.first(where: {$0.track == (self.currentSong!.track+1)})!
      self.setPlayerItem(song: self.currentSong!)
      // don't start if the player is in pause.
      if self.isPlaying {
        print("player is not in pause")
        self.player.play()
      }
    }
  }
  
  func previous() {
    if self.currentSong!.track > 1 {
      self.player.pause()
      self.currentSong = self.album!.songs.first(where: {$0.track == (self.currentSong!.track-1)})!
      self.setPlayerItem(song: self.currentSong!)
      // don't start if the player is in pause.
      if self.isPlaying {
        print("player is not in pause")
        self.player.play()
      }
    }
  }
}
